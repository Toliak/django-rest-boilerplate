import pytest
from django.core.exceptions import ValidationError

from myproject.core.models import CatalogItem


@pytest.mark.django_db
def test_filter_selector_double_clean_fields_max_min_invalid():
    item = CatalogItem(name='Item1',
                       price=-1,
                       description='A test item', )

    with pytest.raises(ValidationError):
        item.clean_fields()
