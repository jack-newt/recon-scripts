#!/bin/bash
GREEN='\033[0;32m'
RESET='\033[0m'

output_file="dirb.txt"

while getopts ':o' output; do
	case $output in
		o)
			output_file="$OPTARG"
			[[ "$output_file" == *.txt ]] || output_file="$output_file.txt"
			;;
		\?)
			exit 1
			;;
	esac
done

echo "Enter your domain: "
read -p "> " Domain


whois_output=$(whois "$Domain")
dig_output=$(dig "$Domain")
dig_A_output=$(dig "$Domain" +short A)
dig_MX_output=$(dig "$Domain" +short MX)
dig_TXT_output=$(dig "$Domain" +short TXT)

echo;
echo "$whois_output" | grep -e "Domain Name: " -e "Registrar: " -e "Registrant Email: " -e "Creation Date: " -e "Expiration Date: " | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//' | awk '!seen[$0]++'
echo;
echo "$dig_A_output"
echo;
echo "$dig_MX_output"
echo;
echo "$dig_TXT_output"
