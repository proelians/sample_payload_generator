// Compile instructions
// C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /unsafe /platform:x86 /out:08_WebRequester_86.exe 08_WebRequester_86.cs
using System;
using System.Net;
using Microsoft.Win32;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebRequester
{
    class Program
    {
        static void Main(string[] args)
        {
            // Simple web requester
            WebRequest myWebRequest = System.Net.WebRequest.Create("http://LOCAL_IP:LOCAL_PORT/HTTP_08_WebRequester_86.exe");

            RegistryKey RegKey = Registry.Users;
            String[] names = RegKey.GetSubKeyNames();
            //RegKey.Name should be HKEY_USERS
            //Console.WriteLine("Subkeys of " + RegKey.Name);

            string webProxy = null;

            foreach (String s in names) 
            {
                // Uncomment for debugging
                //Console.WriteLine(s);
                if (s.Contains("S-1-5-21"))
                {
                    //Gets the proxy of the first user found
                    webProxy = (string) Registry.GetValue("HKEY_USERS\\" + s + "\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings","ProxyServer","");
                    // Uncomment for debugging
                    //Console.WriteLine("Proxy Found " + webProxy);
                    break;
                }
            }

            // Comment this section to remove the proxy or edit webProxy to manually set the proxy
            //WebProxy proxyObject = new WebProxy("http://" + webProxy, true);
            //myWebRequest.Proxy = proxyObject;
  
            //myWebRequest.Proxy = WebRequest.GetSystemWebProxy(); <-- it worked only with nt authority\system

            WebResponse myWebResponse = myWebRequest.GetResponse();
        }
    }
}
