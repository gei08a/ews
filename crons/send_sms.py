#!/usr/bin/env python
import csv
import datetime
import os
import sys
import syslog

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ews.settings")

from farmers.models import Farmer, Market, Quote, Subscription
from session import Session

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

    license_key = ''
    sms = Session(license_key)

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
            sms.simple_sms_send(phone_number, message)
        except Exception, e:
            syslog.syslog(str(e))
