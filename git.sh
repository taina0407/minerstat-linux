#! /usr/bin/bash
git config --global user.email "test@test.com"
git config --global user.name "test"
git pull --rebase
git add * -f
git commit -a -m "AutoUpdate"
git pull origin master
