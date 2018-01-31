if ! screen -list | grep -q "dummy"; then

screen -A -m -d -S dummy sleep 86400

echo "boot" > random.txt

echo ""
echo "-------- INSTALLING FAKE DUMMY PLUG ------------"
echo "Please wait.."
sleep 1
sudo update-grub
sudo nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 --use-display-device="DFP-0" --connected-monitor="DFP-0" --enable-all-gpus
sudo service gdm stop
#screen -A -m -d -S display sudo X
sleep 10
sudo chvt 1
echo ""

#echo "-------- OVERCLOCKING ---------------------------"
#cd /home/minerstat/minerstat-linux/bin
#sudo sh overclock.sh

echo " "
echo "-------- AUTO CONFIGURE NETWORK ADAPTERS --------"
cd /home/minerstat/minerstat-linux/bin
sudo sh dhcp.sh

sleep 2

echo "-------- WAITING FOR CONNECTION -----------------"
echo ""

while ! sudo ping minerstat.com -w 1 | grep "0%"; do
sleep 1
done

echo ""
echo "-------- AUTO UPDATE MINERSTAT ------------------"
echo ""
cd /home/minerstat/minerstat-linux
sudo sh git.sh
echo ""

echo "-------- RUNNING JOBS ---------------------------"
cd /home/minerstat/minerstat-linux/bin
sudo sh jobs.sh
echo ""

echo "-------- REBOOT IN 3 SEC -----------"
sleep 2
sudo reboot -f
fi
