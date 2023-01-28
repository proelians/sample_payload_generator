// Compile instructions
// javac --release 8 ping.java && jar -cvmf 09_ping.mf 09_ping.jar ping.class

import java.net.*;
import java.io.*;
import java.util.*;

public class ping {
  public static void main(String[] args) throws Exception {
  final Runtime rt = Runtime.getRuntime();
  rt.exec("C:\\Windows\\System32\\ping.exe LOCAL_IP");  
  }//End of main
}

