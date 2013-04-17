#!/usr/bin/env python
import csv
import datetime
import MySQLdb
import os
import sys
import syslog

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ews.settings")

from django.db import connection
from django.utils import timezone
from farmers.models import Farmer, Market, Quote
from farmers.models import SMS, Subscription
from session import Session

def dictfetch(cursor):
    "Returns all rows from a cursor as a dict"
    desc = cursor.description
    return [
        dict(zip([col[0] for col in desc], row))
        for row in cursor.fetchall()
    ]

def get_license_key():
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM cdyne_config WHERE id = 1")
    row = dictfetch(cursor)

    return row[0]['license_key']

if __name__ == "__main__":

    m = Market.objects.all()
    market_abbr = {}

    for item in m:
        market_abbr[item.id] = item.abbreviation

    f = Farmer.objects.all()
    farmers = []

    for item in f:
        farmers.append(item.phone_number)

    today = datetime.date.today()

#    q = Quote.objects.filter(date=str(today)).order_by('market')
    q = Quote.objects.filter(date='2013-03-30').order_by('market')
    if not q:
        sys.exit()
    quotes = {}

    market_id = 0
    for item in q:
        if market_id != item.market_id:
            market_id = item.market_id
            quotes[market_id] = {}
        quotes[market_id][item.crop_id] = str(item.price)

    license_key = get_license_key()
    session = Session(license_key)

    for phone_number in farmers:
        s = Subscription.objects.select_related().filter(phone_number_id=phone_number).order_by('market')
        market_id = 0
        substring = ''
        substrings_list = []
        for item in s:
            if market_id != item.market_id:
                market_id = item.market_id
                if substring:
                    substrings_list.append(substring[:-1])
                substring = market_abbr[market_id] + '-'
            substring += str(item._crop_cache) + ':' + quotes[market_id][item.crop_id] + ','
        substrings_list.append(substring[:-1])
        message = '/'.join(substrings_list)
        try:
            response = session.send_sms(phone_number, message)
            if not response['Queued']:
                syslog.syslog('Error - Failed to send message to %s. - %s' % (phone_number,response['SMSError']))
            sms = SMS(phone_number = Farmer.objects.get(phone_number=phone_number),
                      message = message,
                      posttime = timezone.now(),
                      cdyne_posttime = response['SentDateTime'],
                      cdyne_sms_id = response['MessageID'],
                      cancelled = response['Cancelled'],
                      error = response['SMSError'],
                      queued = response['Queued'],
                      sent = response['Sent'])
            sms.save()
        except Exception, e:
            syslog.syslog(str(e))
