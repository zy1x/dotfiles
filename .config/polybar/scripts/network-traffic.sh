#!/bin/bash

print_bytes() {
    #if [ "$1" -eq 0 ] || [ "$1" -lt 100 ]; then
    #    bytes="0 kB/s"
    #elif [ "$1" -lt 1000 ]; then
    #    bytes="0$(echo "scale=1;$1/1000" | bc -l ) kB/s"
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kB"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB"
    fi

    echo "$bytes"
}

INTERVAL=3
INTERFACES="enp3s0"

declare -A bytes

for interface in $INTERFACES; do
    bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
    bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"
done

while true; do
    down=0
    up=0

    for interface in $INTERFACES; do
        bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
        bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

        bytes_down=$((((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]})) / INTERVAL))
        bytes_up=$((((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]})) / INTERVAL))

        down=$(((( "$down" + "$bytes_down" ))))
        up=$(((( "$up" + "$bytes_up" ))))

        bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
        bytes[past_tx_$interface]=${bytes[now_tx_$interface]}
    done

    echo "$(print_bytes $down) $(print_bytes $up)"

    sleep $INTERVAL
done
