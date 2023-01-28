Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
command = "nslookup DNS_06_nslookup.vbs LOCAL_IP"
objShell.Run command,0

