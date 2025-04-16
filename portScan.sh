#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m'

while getopts 'o:' output; do
	case $output in
		o)
			output_file="$OPTARG"
			[[ "$output_file" == *.txt ]] || output_file="$output_file.txt"
			;;
		*)	
			exit 1
			;;
	esac
done

echo -e "${GREEN}
====================================================================
	 ____  _____  ____  ____  ___   ___    __    _  _ 
	(  _ \(  _  )(  _ \(_  _)/ __) / __)  /__\  ( \( )
	 )___/ )(_)(  )   /  )(  \__ \( (__  /(__)\  )  ( 
	(__)  (_____)(_)\_) (__) (___/ \___)(__)(__)(_)\_)

====================================================================
${RESET}
1. Simple Scan
2. Sneaky Scan
3. Aggressive Scan
4. Quick Scan
5. Deep Scan
6. UDP Simple Scan
7. UDP Quick Scan
8. UDP Deep Scan
9. ARP Scan
"

echo "Enter your Selection: "
read -p "> " Selection
echo "Enter your IP/Range: "
read -p "> " IP
echo;

# to-do: while loop, back option, quit option
case "$Selection" in
	1)
		echo "Simple Scan Selected!"
		result=$(sudo nmap -sC -sV -T4 "${IP}")
		;;
	2)
		echo "Sneaky Scan Selected!"
		result=$(sudo nmap -sC -sV -sS -T1 --scan-delay 250ms -Pn "${IP}")
		;;
	3)	
		echo "Aggressive Scan Selected!"
		result=$(sudo nmap -A "${IP}")
		;;
	4)
		echo "Quick Scan Selected!"
		result=(sudo nmap -T5 -version-light -F "${IP}")
		;;
	5)
		echo "Deep Scan Selected!"
		result=(sudo nmap -p- -sC -sV -version-all --max-retries 2 --reason "${IP}")
		;;
	6)
		echo "UDP Simple Scan Selected!"
		result=(sudo nmap --top-ports 20 -sU -sV "${IP}")
		;;
	7)
		echo "UDP Quick Scan Selected!"
		result=(sudo nmap --top-ports 10 -sU -T5 "${IP}")
		;;
	8)
		echo "UDP Deep Scan Selected!"
		result=(sudo nmap -p- -sU -sV --max-retries 2 --reason "${IP}")
		;;
	9)
		echo "ARP Scan Selected!"
		result=(sudo nmap -sn -PR "${IP}")
		;;
	*)
		echo "Select a valid number!"
		;;
esac


if [[ -n "$output_file" ]]; then
	echo; echo "Output sent to $output_file!"
	printf "%s\n" "${result}" > $output_file
else
	printf "%s\n" "${result}"
fi


