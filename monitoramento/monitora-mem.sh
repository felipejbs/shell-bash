#!/bin/bash

LOGS="/home/$USER/mem.info"

DATA=$(date "+%Y-%m-%d %H:%M:%S")

MEM_INFO=$(free -m | awk 'NR==2 {print "Total: " $2 "MB | Usado: " $3 "MB | Livre: " $4 "MB"}')

echo "$DATA - $MEM_INFO" >> "$LOGS"
