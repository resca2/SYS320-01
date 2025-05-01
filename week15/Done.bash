#!/bin/bash

myIP=$(bash myIP.bash)


# Todo-1: Create a helpmenu function that prints help for the script

function helpmenu(){
	echo -e "\n\tHELP MENU"
	echo -e"---------------------"
	echo -e "-n Add -n as an argument for this script to use NMAP"
	echo -e " -n external: External NMAP scan"
	echo -e " -n internal: Internal NMAP scan"
	echo -e "-s: Add -s as an argument for this script to use ss"
	echo -e " -s external: External ss(Netstat) scan"
	echo -e " -s internal: Internal ss(Netstat) scan"
	echo -e "\nUsage: bash networkchecker.bash -n/-s external/internal"
	echo -e "------------------------"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)

function ExternalListeningPorts(){
	elpo=$(ss -ltpn | awk -F'[[ :(),]+' '!/127.0.0.1/ && /LISTEN/ { print $5,$9 }' | tr -d "\"")
	echo "$elpo"

}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}

#input arguments

if [ "$#" -ne 2 ]; then
	helpmenu
	exit 1
fi

case "$1" in
	-n)
	if [ "$2" = "external" ]; then
		ExternalNmap
	elif [ "$2" = "internal" ]; then
		InternalNmap
	else
		echo "Invalid argument for -n: $2"
		helpmenu
	fi
	;;
	-s)
	if [ "$2" = "external" ]; then
		ExternalListeningPorts
	elif [ "$2" = "internal" }; then
		InternalListeningPorts
	else
		echo "Invalid argument for -s: $2"
		helpmenu
	fi
	;;
	*)
		echo "Illegal options: $1"
		helpmenu
	;;
esac
# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)


