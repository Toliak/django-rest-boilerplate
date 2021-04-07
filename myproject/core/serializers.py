from django.http import HttpRequest
from rest_framework import serializers

from myproject.core.models import CatalogItemImage


class CatalogItemImageSerializer(serializers.Serializer):
    full = serializers.SerializerMethodField(method_name='get_full_url')
    thumbnail = serializers.SerializerMethodField(method_name='get_thumb_url')

    def get_full_url(self, image: 'CatalogItemImage'):
        assert self.context.get('request') is not None

        request: HttpRequest = self.context.get('request')
        return image.image.url

    def get_thumb_url(self, image: 'CatalogItemImage'):
        assert self.context.get('request') is not None

        request: HttpRequest = self.context.get('request')
        return image.image.thumbnail.url


class CatalogItemSerializer(serializers.Serializer):
    itemType = serializers.CharField(source='item_type')
    name = serializers.CharField()
    price = serializers.IntegerField()
    description = serializers.CharField()
    weight = serializers.IntegerField()
    material = serializers.CharField()
    images = CatalogItemImageSerializer(read_only=True, many=True)
