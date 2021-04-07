from rest_framework import views
from rest_framework.response import Response

from myproject.core.models import CatalogItem
from myproject.core.serializers import CatalogItemSerializer


class IndexView(views.APIView):
    def get(self, request, *args):
        items = CatalogItem.objects.all()

        serialized = CatalogItemSerializer(items,
                                           many=True,
                                           context=dict(request=request))
        return Response(serialized.data)
