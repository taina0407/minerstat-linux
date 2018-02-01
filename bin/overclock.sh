#!/bin/bash
echo "*-*-* Overclocking in progress *-*-*"
#cd /home/minerstat/minerstat-linux/bin/

NVIDIA="$(nvidia-smi -L)"

if [ ! -z "$NVIDIA" ]; then

if echo "$NVIDIA" | grep -iq "^GPU 0:" ;then

DONVIDIA="YES"

fi
fi


AMD="$(./amdmeminfo | grep 'information available')"

if echo "$AMD" | grep -iq "^no version information available" ;then

DOAMD="YES"

fi


echo ""
echo "--------------------------"

TOKEN="$(cat ../config.js | grep 'global.accesskey' | sed 's/global.accesskey =//g' | sed 's/;//g')"
WORKER="$(cat ../config.js | grep 'global.worker' | sed 's/global.worker =//g' | sed 's/;//g')"

echo "TOKEN: $TOKEN"
echo "WORKER: $WORKER"

echo "--------------------------"

if [ ! -z "$DONVIDIA" ]; then

wget -qO doclock.sh "https://minerstat.com/getclock.php?type=nvidia&token=$TOKEN&worker=$WORKER"
sleep 3
sudo sh doclock.sh

fi

if [ ! -z "$DOAMD" ]; then

wget -qO doclock.sh "https://minerstat.com/getclock.php?type=amd&token=$TOKEN&worker=$WORKER"
sleep 3
sudo sh doclock.sh

fi
