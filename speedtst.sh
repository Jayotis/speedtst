#!/bin/bash
IFS=$'\n'
arr=($(speedtest-cli --list))
unset IFS
read -r -d ')' id <<< "${ISP}"
for i in "${arr[@]}"
do
	if echo $i | grep -q "Telus";  #test your ISP first
	then
		read -r -d ')' id <<< $i && break
	fi
done
unset IFS
date
speedtest-cli --server $id
arsize=${#arr[@]}
top=(arsize / 10) #top 10%
for ((i=0;i<=3;i++)); do
	echo $'\n''Next server'
	date
	random=$[RANDOM%arsize]
	read -r -d ')' id <<< "${arr[$random]}" #Randomly test a server (probably) outside your ISP network
	speedtest-cli --server $id
done
exit

