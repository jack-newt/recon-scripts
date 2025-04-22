#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m'

output_file="siteReport.txt"
output_to_file=false

while getopts ':o:' output; do
	case $opt in
		o)
			output_file="$OPTARG"
			[[ "$output_file" == *.txt ]] || output_file="$output_file.txt"
			output_to_file=true
			;;
		\?)
			exit 1
			;;
	esac
done

echo -e "${GREEN}
===================================================================
	 ___  ____  ____  ____  ___   ___    __    _  _ 
	/ __)(_  _)(_  _)( ___)/ __) / __)  /__\  ( \( )
	\__ \ _)(_   )(   )__) \__ \( (__  /(__)\  )  ( 
	(___/(____) (__) (____)(___/ \___)(__)(__)(_)\_)

===================================================================
${RESET}"

echo "Enter your domain: "
read -p "> " Domain

whois_output=$(whois "$Domain")
dig_output=$(dig "$Domain")
dig_A_output=$(dig "$Domain" +short A)
dig_MX_output=$(dig "$Domain" +short MX)
dig_TXT_output=$(dig "$Domain" +short TXT)

scan=""
scan+="\n${GREEN}========== DOMAIN INFORMATION ==========${RESET}"
scan+="\n$(echo "$whois_output" | grep -e "Domain Name: " -e "Registrar: " -e "Registrant Email: " -e "Creation Date: " -e "Expiration Date: " | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//' | awk '!seen[$0]++')\n"
scan+="\n${GREEN}========== IPv4 Adresses ==========${RESET}"
scan+="\n$dig_A_output\n"
scan+="\n${GREEN}========== Mail Servers ==========${RESET}"
scan+="\n$dig_MX_output\n"
scan+="\n${GREEN}========== TXT Records ==========${RESET}"
scan+="\n$dig_TXT_output\n"

echo -e "$scan"

if [[ -n "$output" ]]; then
	echo -e "$scan" > "$output_file"
	echo "Output sent to $output_file!"
fi
