A few scripts that I've made to streamline commands I commonly use in CTFs, HtB boxes, and bug bounty hunting. Also serves as a project to better learn bash and the arguments for common commands.
---
# portScan.sh
Essentially an nmap wrapper that includes its most common use cases. Options include:

1) Simple Scan
    `nmap -sC -sV -sS -T4 $"{IP}"`

2) Sneaky Scan
    `nmap -sC -sV -sS -T1 --scan-delay 250ms -Pn $"{IP}"`

3) Aggressive Scan
    `nmap -A $"{IP}"`

4) Quick Scan
    `nmap -T5 -version-light -F $"{IP}"`

5) Deep Scan
    `nmap -p- -sC -sV -version-all --max-retried 2 --reason $"{IP}"`

6) UDP Simple Scan
    `nmap --top-ports 20 -sU -sV $"{IP}"`

7) UDP Quick Scan
    `nmap --top-ports 10 -sU -T5 $"{IP}"`

8) UDP Deep Scan
    `nmap -p- -sU -sV --max-retries 2 --reason $"{IP}"`

9) ARP Scan
    `nmap -sn -PR $"{IP}"`
---
