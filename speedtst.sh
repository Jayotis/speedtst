#!/bin/bash
IFS=$'\n'
arr=($(speedtest-cli --list)) #get list of servers
unset IFS
arsize=${#arr[@]}
for i in "${arr[@]}"
do
        if echo $i | grep -q "Telus";    #test your ISP first
        then
                read -r -d ')' id <<< $i && break
        fi
done
unset IFS
date
speedtest-cli --server $id
top=(arsize / 10) #top 10%
for ((i=0;i<=3;i++)); do
        echo $'\n''Next server'
        date
        random=$[RANDOM%top]
        read -r -d ')' id <<< "${arr[$random]}"  #test 4 random servers (probably) outside your ISP network
        speedtest-cli --server $id
done
exit


