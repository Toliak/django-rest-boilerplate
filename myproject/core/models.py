from django.core import validators
from django.db import models
from django.utils.translation import gettext_lazy as _
from model_utils.managers import InheritanceManager
from stdimage import StdImageField


class DateTrackerMixin(models.Model):
    created_at = models.DateTimeField(auto_now_add=True,
                                      verbose_name=_('Date created'))
    updated_at = models.DateTimeField(auto_now=True,
                                      verbose_name=_('Date modified'))

    class Meta:
        abstract = True


class CatalogItem(DateTrackerMixin, models.Model):
    class ItemType(models.TextChoices):
        SOMETHING = 'FG', _('Something')

    item_type = models.CharField(
        max_length=2,
        choices=ItemType.choices,
        default=ItemType.SOMETHING,
        verbose_name=_('Item category')
    )

    name = models.CharField(max_length=128,
                            verbose_name=_('Name'))
    price = models.IntegerField(validators=[validators.MinValueValidator(0)],
                                verbose_name=_('Price'))

    description = models.TextField(verbose_name=_('Brief description'))

    weight = models.FloatField(default=None,
                               null=True,
                               blank=True,
                               verbose_name=_('Weight, kg'))
    material = models.CharField(default=None,
                                null=True,
                                blank=True,
                                max_length=128,
                                verbose_name=_('Material'))

    objects = InheritanceManager()


class CatalogItemImage(DateTrackerMixin, models.Model):
    item = models.ForeignKey(to=CatalogItem,
                             null=True,
                             on_delete=models.SET_NULL,
                             verbose_name=_('Catalog item'))
    image = StdImageField(upload_to='itemImages',
                          variations={
                              'thumbnail': {"width": 288, "height": 150,
                                            "crop": True}
                          },
                          verbose_name=_('Image'),
                          delete_orphans=True, )

    def __str__(self) -> str:
        return f'{_("Image for")} {str(self.item)}'

    class Meta:
        verbose_name = _('Catalog. Image')
        verbose_name_plural = _('Catalog. Images')
