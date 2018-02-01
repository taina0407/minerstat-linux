#!/bin/bash
exec 2>/dev/null
echo "*** AMD Overclocking Tool @coinscrow ***"
echo "*** Special thanks to: matszpk for amdcovc ***"

if [ ! $1 ]; then
echo ""
echo "--- EXAMPLE ---"
echo "./overclock_amd a b c d e"
echo "a = GPUID"
echo "b = Memory Clock"
echo "c = Core Clock"
echo "d = Fan Speed"
echo "e = Vddc Voltage"
echo ""
echo "-- Full Example --"
echo "./overclock_amd 0 1750 1100 80 1.11"
echo ""
fi

if [ $1 ]; then
GPUID=$1
MEMCLOCK=$2
CORECLOCK=$3
FANSPEED=$4
VDDC=$5

./amdcovc coreclk:$GPUID=$CORECLOCK
./amdcovc memclk:$GPUID=$MEMCLOCK
./amdcovc fanspeed:$GPUID=$FANSPEED
./amdcovc vcore:$GPUID=$VDDC

echo ""
echo "*** https://minerstat.com ***"
echo ""

sleep 2
sudo chvt 1

fi
