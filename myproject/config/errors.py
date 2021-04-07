import os

import environ

# reading .env file
environ.Env.read_env()

# pe.toliak.ru for log collecting
PE_TOKEN = os.getenv('PE_TOKEN')
PE_URL = os.getenv('PE_URL')
