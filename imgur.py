from imgur_python import Imgur
import webbrowser
import stepic
import wget
from PIL import Image

imgur_client = Imgur({'client_id': 'nomor handphone saya tidak bisa digunakan untuk daftar imgut. Maaf pak'})
auth_url = imgur_client.authorize()
webbrowser.open(auth_url)

url = "https://i.imgur.com/ILDARsD.png"

wget.download(url, './gambar.png')

gambar = Image.open('./gambar.png')


gambarencode = stepic.encode(gambar, b'message')
gambarencode.save('gambar.png', 'PNG')

message = stepic.decode(gambarencode)

print(message)

file = gambarencode
title = 'judul'
description = 'deskripsi'
album = None
disable_audio = 0

imgur_client.image_upload(file, title, description, album, disable_audio)



