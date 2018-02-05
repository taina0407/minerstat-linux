#!/bin/bash
exec 2>/dev/null
echo "*** Nvidia Overclocking Tool @coinscrow ***"

if [ ! $1 ]; then
echo ""
echo "--- EXAMPLE ---"
echo "./overclock_nvidia a b c d e"
echo "a = GPUID"
echo "b = POWER LIMIT in Watts (Example: 120 = 120W) [ROOT REQUIRED]"
echo "c = GLOBAL FAN SPEED (100 = 100%)"
echo "d = Memory Offset"
echo "e = Core Offset"
echo ""
echo "-- Full Example --"
echo "./overclock_nvidia 0 120 80 1300 100"
echo ""
fi

if [ $1 ]; then
GPUID=$1
POWERLIMITINWATT=$2
FANSPEED=$3
MEMORYOFFSET=$4
COREOFFSET=$5

sudo nvidia-smi -pm 1
if [ "$POWERLIMITINWATT" -ne 0 ]
then
sudo nvidia-smi -i $GPUID -pl $POWERLIMITINWATT
fi
sudo nvidia-settings -c :0 -a '[gpu:'"$GPUID"']/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed='"$FANSPEED"'';
sudo nvidia-settings -c :0 -a '[gpu:'"$GPUID"']/GPUMemoryTransferRateOffset[3]='"$MEMORYOFFSET"''
sudo nvidia-settings -c :0 -a '[gpu:'"$GPUID"']/GPUGraphicsClockOffset[3]='"$COREOFFSET"''

echo ""
echo "*** https://minerstat.com ***"
echo ""

sleep 2
sudo chvt 1

fi
