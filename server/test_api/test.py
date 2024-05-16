import requests
from requests_toolbelt.multipart.encoder import MultipartEncoder

image_path = "test-data.jpg"

multipart_data = MultipartEncoder(
    fields={
        "name": "Tu Khanh", 
        "image": ('filename', open(image_path, 'rb'), 'image/jpeg,image/png,image/jpg')
    }
)

response = requests.post(
    'http://192.168.1.34:3000/api/add-history',
    data=multipart_data,
    headers={'Content-Type': multipart_data.content_type}
)

if response.status_code == 200:
    print('Product added successfully:', response.json())
else:
    print('Error adding product:', response.status_code, response.text)
