#!/bin/bash

declare -a orders=("espresso 65" "cappucino 90" "mocha 80" "latte 70" "chocolate 60" "greentea 60")

for _ in $(seq 1 100)
do
    while true
    do
        id=$((1 + RANDOM % 10000)) # $RANDOM, 15 bit, 0-32767 -> id=1-1000, and $/${} is unnecessary on arithmetic variables because the contents of $((..)) is first expanded into a string, and then evaluated as an expression
        if ((id >= 1 && id <= 801)) || ((id >= 5001 && id <= 5945)) || ((id >= 8000 && id <= 8501));
        then
            break
        else
            continue
        fi
    done
    timestamp=$(date "+%s")
    echo "$id|${orders[$RANDOM % ${#orders[@]}]}|$timestamp" >> /data/flume/source/hdfs/order_"${timestamp}".txt # ${#array_name[@]} = array length
    sleep 30
done
