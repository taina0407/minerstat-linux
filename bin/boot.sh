if ! screen -list | grep -q "dummy"; then

screen -A -m -d -S dummy sleep 86400

echo "boot" > random.txt

echo ""
echo "-------- INSTALLING FAKE DUMMY PLUG ------------"
echo "Please wait.."
sleep 1
sudo update-grub
sudo nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 --use-display-device="DFP-0" --connected-monitor="DFP-0" --enable-all-gpus
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
#sudo service lightdm start
#sleep 10
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

echo "-------- INITALIZING MINERSTAT CLIENT -----------"
cd /home/minerstat/minerstat-linux
screen -A -m -d -S minerstat-console sh /home/minerstat/minerstat-linux/start.sh;
echo ""
echo "Minerstat has been started in the background.."
echo "Please wait for console output.."
sleep 7
screen -x minerstat-console
fi
