#!/bin/bash
 
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.
show_help(){
        echo "Sample Payload Generator Commands"
        echo -e "\nUsage:\n$0 -i <interface> (Default: eth0) -H <host> -P <port> (Default 80) -d <domain>"
        echo -e "$0 -i eth1"
        echo -e "$0 -H 192.168.1.1\n"
        }
# Default value
interface=eth0
LPORT=80

# Colours
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
RESET="\033[00m"       # Normal

# Initialize our own variables:
while getopts "h?i:H:P:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    H)  LHOST=$OPTARG
        ;;
    P)  LPORT=$OPTARG
        ;;
    i)  interface=$OPTARG
        ;;
    esac
done
shift $((OPTIND-1))
 
[ "$1" = "--" ] && shift
 
# Grap the IP address of the interface
if [ -z $LHOST ]; then 
   LHOST=`ifconfig $interface | grep 'inet ' |  awk '{print $2}'`
   # if the interface does not have an IP address, exit
   if [ -z $LHOST ]; then
      echo "LHOST empty. Use -H or -i"
      exit 0
   fi
fi

echo -e "${GREEN}[+]${RESET} IP address: ${GREEN} $LHOST ${RESET}"

# if output folder does not exist, create one.
# else delete and create one
# output output_$LHOST
if [ -d "output_$LHOST" ]
then
  echo -e "${GREEN}[+]${RESET} Deleted previous output folder"
  rm -fr output_$LHOST
  mkdir output_$LHOST output_$LHOST/00_HTTP output_$LHOST/01_DNS output_$LHOST/02_ICMP
else
  mkdir output_$LHOST output_$LHOST/00_HTTP output_$LHOST/01_DNS output_$LHOST/02_ICMP
fi

# Generate HTTP Payloads
for payload_file in `ls 00_HTTP`;
  do cat 00_HTTP/$payload_file | sed "s/LOCAL_IP/$LHOST/g;s/LOCAL_PORT/$LPORT/g" > output_$LHOST/00_HTTP/$payload_file
done
echo -e "${GREEN}[+]${RESET} Generated HTTP Payloads"

# Generate DNS Payloads
for payload_file in `ls 01_DNS`;
  do cat 01_DNS/$payload_file | sed "s/LOCAL_IP/$LHOST/g;s/LOCAL_PORT/$LPORT/g" > output_$LHOST/01_DNS/$payload_file
done
echo -e "${GREEN}[+]${RESET} Generated DNS Payloads"

# Generate ICMP Payloads
for payload_file in `ls 02_ICMP`;
  do cat 02_ICMP/$payload_file | sed "s/LOCAL_IP/$LHOST/g;s/LOCAL_PORT/$LPORT/g" > output_$LHOST/02_ICMP/$payload_file
done
echo -e "${GREEN}[+]${RESET} Generated ICMP Payloads"

echo -e "${YELLOW}[-]${RESET} Compiling EXE payloads"
mcs -platform:x86 -out:output_$LHOST/00_HTTP/08_WebRequester_86.exe output_$LHOST/00_HTTP/WebRequester_86.cs
mcs -platform:x86 -out:output_$LHOST/00_HTTP/09_WebRequester_86_p.exe output_$LHOST/00_HTTP/WebRequester_86_p.cs
x86_64-w64-mingw32-g++ -static-libgcc -static-libstdc++ output_$LHOST/01_DNS/nslookup.cpp -o output_$LHOST/01_DNS/00_nslookup.exe
x86_64-w64-mingw32-g++ -static-libgcc -static-libstdc++ output_$LHOST/02_ICMP/ping.cpp -o output_$LHOST/02_ICMP/12_ping.exe

echo -e "${YELLOW}[-]${RESET} Compiling Java Payloads"
javac --release 8 output_$LHOST/00_HTTP/java.java && jar -cvmf output_$LHOST/00_HTTP/java.mf output_$LHOST/00_HTTP/19_java.jar output_$LHOST/00_HTTP/java.class
javac --release 8 output_$LHOST/00_HTTP/java_p.java && jar -cvmf output_$LHOST/00_HTTP/java_p.mf output_$LHOST/00_HTTP/20_java_p.jar output_$LHOST/00_HTTP/java_p.class

javac --release 8 output_$LHOST/01_DNS/nslookup.java && jar -cvmf output_$LHOST/01_DNS/nslookup.mf output_$LHOST/01_DNS/08_nslookup.jar output_$LHOST/01_DNS/nslookup.class
javac --release 8 output_$LHOST/02_ICMP/ping.java && jar -cvmf output_$LHOST/02_ICMP/ping.mf output_$LHOST/02_ICMP/09_ping.jar output_$LHOST/02_ICMP/ping.class

echo -e "${GREEN}[+]${RESET} Output folder: ${GREEN} output_$LHOST ${RESET}"
