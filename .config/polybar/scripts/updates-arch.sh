#!/bin/sh

if ! updates=$(checkupdates 2> /dev/null | wc -l ); then
    echo " 0"
fi

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo " 0"
fi
