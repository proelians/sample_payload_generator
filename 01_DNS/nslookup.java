import java.net.*;
import java.io.*;
import java.util.*;

public class nslookup {
  public static void main(String[] args) throws Exception {
  final Runtime rt = Runtime.getRuntime();
  rt.exec("C:\\Windows\\System32\\nslookup.exe DNS_08_nslookup.jar LOCAL_IP");  
  }//End of main
}

