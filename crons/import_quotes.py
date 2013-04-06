#!/usr/bin/env python
import csv
import datetime
import os

from django.utils import timezone
from farmers.models import Crop, Market, Quote

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ews.settings")
    with open('quotes.csv', 'rb') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for row in spamreader:
            row = row[0].split(',')
            market_obj = Market.objects.get(id=row[0])
            crop_obj = Crop.objects.get(id=row[1])
            q = Quote(date=timezone.now(),
                      market=market_obj,
                      crop=crop_obj,
                      price=row[2])
            q.save()
