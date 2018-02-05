#! /usr/bin/bash
git config --global user.email "dump@minerstat.com"
git config --global user.name "minerstat"
RESPONSE="$(git pull --no-edit)"

sleep 1

if echo "$RESPONSE" | grep -iq "^commit your changes" ;then

sleep 2

sudo git commit -a -m "Init"
sudo git merge

fi
