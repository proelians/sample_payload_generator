// Compile instructions
// javac --release 8 java.java && jar -cvmf java.mf 19_java.jar java.class

import java.net.*;
import java.io.*;
import java.util.*;

public class java {
  public static void main(String[] args) throws Exception {
	URL myurl = new URL("http://LOCAL_IP:LOCAL_PORT/HTTP_19_java.jar");
	URLConnection myconn = myurl.openConnection();
	BufferedReader in = new BufferedReader(new InputStreamReader(myconn.getInputStream()));
	String inputLine;

	while ((inputLine = in.readLine()) != null) 
		System.out.println(inputLine);
	in.close();
  }
}

