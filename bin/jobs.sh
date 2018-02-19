#!/bin/bash
find '/home/minerstat/minerstat-linux' -name "*log.txt" -type f -delete
echo "Log files deleted"
sudo dmesg -n 1
sudo apt clean
