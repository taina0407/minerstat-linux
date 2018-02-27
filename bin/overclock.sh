#!/bin/bash
echo "*-*-* Overclocking in progress *-*-*"
#cd /home/minerstat/minerstat-linux/bin/

DEVICE=$(sudo lshw -short | grep AMD | wc -l)
if [ "$DEVICE" -gt "0" ]; then
DIVIDE=$((DEVICE / 2))
else
DIVIDE="0"
fi

NVIDIA="$(nvidia-smi -L)"

if [ ! -z "$NVIDIA" ]; then

if echo "$NVIDIA" | grep -iq "^GPU 0:" ;then

DONVIDIA="YES"

fi
fi

if [ "$DIVIDE" -gt "0" ]; then

DOAMD="YES"

fi


echo ""
echo "--------------------------"

TOKEN="$(cat /home/minerstat/minerstat-linux/config.js | grep 'global.accesskey' | sed 's/global.accesskey =//g' | sed 's/;//g')"
WORKER="$(cat /home/minerstat/minerstat-linux/config.js | grep 'global.worker' | sed 's/global.worker =//g' | sed 's/;//g')"

echo "TOKEN: $TOKEN"
echo "WORKER: $WORKER"

echo "--------------------------"

sudo rm doclock.sh

sleep 1

if [ ! -z "$DONVIDIA" ]; then

wget -qO doclock.sh "https://minerstat.com/getclock.php?type=nvidia&token=$TOKEN&worker=$WORKER"
sleep 3
sudo sh doclock.sh

fi

if [ ! -z "$DOAMD" ]; then

wget -qO doclock.sh "https://minerstat.com/getclock.php?type=amd&token=$TOKEN&worker=$WORKER&nums=$DIVIDE"
sleep 3
sudo sh doclock.sh

fi
