#!/bin/bash
exec 2>/dev/null
echo "Running Clean jobs.."
find '/home/minerstat/minerstat-linux' -name "*log.txt" -type f -delete
echo "Log files deleted"
sudo dmesg -n 1
sudo apt clean
#Deleting Old Kernels
sudo rm /boot/initrd.img-4.10.0-42-lowlatency > /dev/null
sudo rm /boot/initrd.img-4.10.0-42-generic.old-dkms > /dev/null
