Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
command = "ping LOCAL_IP"
objShell.Run command,0

