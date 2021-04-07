import sys
import traceback
from typing import List, Dict

from django.http import HttpRequest
from django.utils.deprecation import MiddlewareMixin

from pe_hook.pe import send_pe_message


class PurpleEntryExceptionHandler(MiddlewareMixin):
    @staticmethod
    def clean_request(request: HttpRequest) -> Dict[str, str]:
        names = ('FILES',
                 'GET',
                 'POST',
                 'content_type',
                 'headers',
                 'method',
                 'path',
                 'path_info',
                 'scheme',
                 'user')

        result = dict()
        for name in names:
            value = getattr(request, name, None)
            if not value:
                continue

            result[name] = str(value)

        return result

    @staticmethod
    def collect_data_to_send(exc: str,
                             trace: List[str],
                             exception: Exception,
                             request: HttpRequest):
        prepared_trace: str = '\n'.join(trace)

        prepared_request: str = ''
        cleaned_request = PurpleEntryExceptionHandler.clean_request(request)
        for key in cleaned_request:
            value = cleaned_request[key]
            prepared_request += f'{key}:\n{value}\n\n{"-" * 15}\n'

        to_send: str = f'''Exception (traceback):
{exc} 

{'-' * 15}
Exception:
{str(exception)} 

{'-' * 15}
{'=' * 15}
Request info:
{prepared_request}

{'=' * 15}
'''
        if len(to_send) > 4090:
            print('A lot of data to send to PE', file=sys.stderr)
            to_send = to_send[:4090]
            
        send_pe_message(title=str(exception),
                        description=to_send,
                        type_m='ERROR')

    def process_exception(self, request, exception):
        if not isinstance(exception, Exception):
            return None

        self.collect_data_to_send(exc=traceback.format_exc(),
                                  trace=traceback.format_stack(),
                                  exception=exception,
                                  request=request)
