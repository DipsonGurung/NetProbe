#!/usr/bin/zsh

ip=$(ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3)
#ip=$(cat ip.txt)
#echo "$ip"

echo "" > output.txt

for i in {1..254}
do
ping -c 1 "$ip.$i" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> output.txt &
done

nmap -sS -Pn -iL output.txt -o result.txt
exit
