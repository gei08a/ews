from django.db import models

class Farmer(models.Model):
    phone_number = models.BigIntegerField(primary_key=True,max_length=10)
    first_name = models.CharField(max_length=200)
    last_name = models.CharField(max_length=200)
    address = models.CharField(max_length=200)

    def __unicode__(self):
        return (self.first_name + ' ' + self.last_name)

class Location(models.Model):
    name = models.CharField(max_length=200)

    def __unicode__(self):
        return self.name

class Market(models.Model):
    name = models.CharField(max_length=200)
    location = models.ForeignKey(Location)
    abbreviation = models.CharField(max_length=200)

    def __unicode__(self):
        return self.location.name + ' - ' + self.name

class Crop(models.Model):
    name = models.CharField(max_length=200)

    def __unicode__(self):
        return self.name

class Quote(models.Model):
    date = models.DateField()
    market = models.ForeignKey(Market)
    crop = models.ForeignKey(Crop)
    price = models.DecimalField(max_digits=10,decimal_places=2)

    def __unicode__(self):
        return str(self.date) + ' - ' + self.market.name + ' - ' + self.crop.name

class Subscription(models.Model):
    phone_number = models.ForeignKey(Farmer)
    market = models.ForeignKey(Market)
    crop = models.ForeignKey(Crop)

    class Meta:
        unique_together = ('phone_number', 'market', 'crop')

    def __unicode__(self):
        return str(self.phone_number)
