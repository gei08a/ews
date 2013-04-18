import sys
import syslog

from django.db import connection
from django.shortcuts import render, render_to_response
from django.utils import timezone
from farmers.models import Farmer, Market, Quote
from farmers.models import SMS, Subscription
from session import Session

def quotes_index(request):
    quotes = Quote.objects.filter(date=timezone.now().strftime('%Y-%m-%d')).order_by('market')
    market = ''
    quote_list = {}

    for quote in quotes:
        if market != quote.market:
            market = quote.market
            quote_list[market] = {}
        quote_list[market][quote.crop] = quote.price

    return render_to_response('quote_index.html',
                              { 'quote_list': quote_list,
                                'date': timezone.now().strftime('%B %d, %Y') })

def sms_send(request):
    info = ''
    response = ''

    if request.method == 'POST': # If the form has been submitted...
        try:
            phone_number = int(request.POST['phone_number'])
        except ValueError:
            info = 'You must enter a valid phone number.'
            return render(request, 'sms_send.html', { 'info': info, 'message': response })
        except Exception:
            info = 'The message could not be sent.'
            return render(request, 'sms_send.html', { 'info': info, 'message': response })

        response = send_sms(phone_number)
        if response:
            info = 'The message was sent.'
        else:
            info = 'The message could not be sent.'

    return render(request, 'sms_send.html', { 'info': info, 'message': response })

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

def send_sms(phone_number):

    m = Market.objects.all()
    market_abbr = {}

    for item in m:
        market_abbr[item.id] = item.abbreviation

    f = Farmer.objects.all()
    farmers = []

    for item in f:
        farmers.append(item.phone_number)

    q = Quote.objects.filter(date=timezone.now().strftime('%Y-%m-%d')).order_by('market')
    if not q:
        return False
    quotes = {}

    market_id = 0
    for item in q:
        if market_id != item.market_id:
            market_id = item.market_id
            quotes[market_id] = {}
        quotes[market_id][item.crop_id] = str(item.price)

    license_key = get_license_key()
    session = Session(license_key)

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
    if not message:
        return False

    try:
#        response = session.send_sms(phone_number, message)
#        if not response['Queued']:
#            syslog.syslog('Error - Failed to send message to %s. - %s' % (phone_number,response['SMSError']))
#        sms = SMS(phone_number = Farmer.objects.get(phone_number=phone_number),
#                  message = message,
#                  posttime = timezone.now(),
#                  cdyne_posttime = response['SentDateTime'],
#                  cdyne_sms_id = response['MessageID'],
#                  cancelled = response['Cancelled'],
#                  error = response['SMSError'],
#                  queued = response['Queued'],
#                  sent = response['Sent'])
#        sms.save()
        return message
    except Exception, e:
        syslog.syslog(str(e))
        return False
