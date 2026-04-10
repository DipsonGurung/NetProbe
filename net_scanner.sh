#!/usr/bin/zsh

# Get network IP
ip=$(ip addr | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d "/" -f1 | cut -d "." -f1,2,3)

echo "Scanning network: $ip.0/24"

echo "" > output.txt

for i in {1..254}
do
    ping -c 1 "$ip.$i" | grep "64 bytes" | awk '{print $4}' | tr -d ":" >> output.txt &
done

# Wait for all background jobs
wait

echo "Active hosts found:"
cat output.txt

# Run nmap scan
nmap -sS -Pn -iL output.txt -oN result.txt

echo "Scan completed. Results saved in result.txt"