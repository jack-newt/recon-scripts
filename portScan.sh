#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m'

# to-do: -o flag to send output to .txt file

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

# to-do: while loop, back option, quit option
case "$Selection" in
	1)
		echo "Simple Scan Selected!"
		sudo nmap -sC -sV -T4 $"{IP}"
		;;
	2)
		echo "Sneaky Scan Selected!"
		sudo nmap -sC -sV -sS -T1 --scan-delay 250ms -Pn $"{IP}"
		;;
	3)	
		echo "Aggressive Scan Selected!"
		sudo nmap -A $"{IP}"
		;;
	4)
		echo "Quick Scan Selected!"
		sudo nmap -T5 -version-light -F $"{IP}"
		;;
	5)
		echo "Deep Scan Selected!"
		sudo nmap -p- -sC -sV -version-all --max-retries 2 --reason $"{IP}"
		;;
	6)
		echo "UDP Simple Scan Selected!"
		sudo nmap --top-ports 20 -sU -sV $"{IP}"
		;;
	7)
		echo "UDP Quick Scan Selected!"
		sudo nmap --top-ports 10 -sU -T5 $"{IP}"
		;;
	8)
		echo "UDP Deep Scan Selected!"
		sudo nmap -p- -sU -sV --max-retries 2 --reason $"{IP}"
		;;
	9)
		echo "ARP Scan Selected!"
		sudo nmap -sn -PR $"{IP}"
		;;
	*)
		echo "Select a valid number!"
		;;
esac
