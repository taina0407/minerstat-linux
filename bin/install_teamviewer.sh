#!/bin/bash
echo "*** Installing TeamViewer ***"
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo dpkg -i teamviewer_amd64.deb
sudo apt-get --assume-yes install -f
sudo teamviewer --daemon enable
echo "*** Teamviewer Installed ***"
teamviewer --passwd minerstat
echo ""
echo "--- Teamviewer ID ----"
teamviewer --info print version, status, id
echo "--- Teamviewer Password: minerstat ---"
