from django.contrib import admin
from django_summernote.admin import SummernoteModelAdmin

from myproject.core.models import CatalogItem, CatalogItemImage


@admin.register(CatalogItem)
class CatalogItemAdmin(SummernoteModelAdmin):
    save_as = True
    list_filter = ['material']
    search_fields = ['name', 'description']
    readonly_fields = ['created_at', 'updated_at']
    summernote_fields = ('description',)


@admin.register(CatalogItemImage)
class CatalogItemImageAdmin(admin.ModelAdmin):
    save_as = True
    list_display = ['item', 'image']
    readonly_fields = ['created_at', 'updated_at']
