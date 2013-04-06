import farmers.models as ews_models
from django.contrib import admin

class SubscriptionInline(admin.StackedInline):
    model = ews_models.Subscription

class FarmerAdmin(admin.ModelAdmin):
    inlines = [
        SubscriptionInline,
    ]

admin.site.register(ews_models.Farmer, FarmerAdmin)
admin.site.register(ews_models.Market)
admin.site.register(ews_models.Crop)
admin.site.register(ews_models.Location)
