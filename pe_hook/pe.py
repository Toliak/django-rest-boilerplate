import traceback

import requests

from myproject.config import errors


def send_pe_message(title: str, description: str, type_m: str = "DEBUG"):
    auth = errors.PE_TOKEN
    r = requests.post(
        url=errors.PE_URL,
        headers={
            'X-PE-Auth-Token': auth,
            'X-PE-Auth-Entity': 'project',
        },
        json={
            "title": title,
            "description": description,
            "key": title.replace(' ', '').lower()[:16],
            "type": type_m,
        })


def capture_exception(exception: Exception):
    trace: str = traceback.format_exc()
    send_pe_message(title=str(exception) or 'Exception',
                    description=trace,
                    type_m='ERROR')
