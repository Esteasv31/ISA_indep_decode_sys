import requests

# Converter API URL
api_url = "https://armconverter.com/api/convert"

# BODY to be send
body = {
  "offset": "0"
}


def convertToHex(code, arch):
  # set body custom params
  body["asm"] = code
  body["arch"] = arch
  response = requests.post(api_url, json=body)
  if(response.status_code == 200):
    result = response.json()['hex']['arm']
    result.pop(0)
    return result
  else:
    print('ERROR')
    return None
