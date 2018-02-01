if ! screen -list | grep -q "dummy"; then

screen -A -m -d -S dummy sleep 86400

echo ""
echo "-------- INIZALIZING FAKE DUMMY PLUG -------------"
echo "Please wait.."
sleep 1
sudo service dgm stop
sleep 3
screen -A -m -d -S display sudo X
echo ""

echo " "
echo "-------- CONFIGURE NETWORK ADAPTERS --------------"
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

echo "-------- OVERCLOCKING ---------------------------"
cd /home/minerstat/minerstat-linux/bin
sudo sh overclock.sh

echo "-------- RUNNING JOBS ---------------------------"
cd /home/minerstat/minerstat-linux/bin
sudo sh jobs.sh
echo ""

echo "-------- INITALIZING MINERSTAT CLIENT -----------"
cd /home/minerstat/minerstat-linux
screen -A -m -d -S minerstat-console sh /home/minerstat/minerstat-linux/start.sh;
echo ""
echo "Minerstat has been started in the background.."
echo "Waiting for console output.."
sleep 5
sudo chvt 1
sleep 10
screen -x minerstat-console
fi
