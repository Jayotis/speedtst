#!/bin/bash
IFS=$'\n'
arr=($(speedtest-cli --list))
unset IFS
read -r -d ')' id <<< "${ISP}"
arsize=${#arr[@]}
for i in "${arr[@]}"
do
	if echo $i | grep -q "Telus";
	then
		read -r -d ')' id <<< $i && break
	fi
done
unset IFS
date
speedtest-cli --server $id
for ((i=0;i<=3;i++)); do
	echo $'\n''Next server'
	date
	random=$[RANDOM%arsize]
	read -r -d ')' id <<< "${arr[$random]}"
	speedtest-cli --server $id
done
exit

