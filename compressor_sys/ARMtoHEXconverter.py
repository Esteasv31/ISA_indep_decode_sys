import requests

api_url = "https://armconverter.com/api/convert"

body = {
  "asm": "sub sp,sp,#32\nstr x0,[sp,8]\nstr x1,[sp]\nstr wzr,[sp,24]\nstr wzr,[sp,28]",
  "offset": "0",
  "arch": ["arm64", "arm"]
}

response = requests.post(api_url, json=body)
print(response.json())
print(response.status_code)