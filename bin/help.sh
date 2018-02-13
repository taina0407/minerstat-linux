#!/bin/bash
echo ""
echo "$(tput setaf 1)miner $(tput setab 7)show miner screen.$(tput sgr 0)"
echo "$(tput setaf 1)mstart $(tput setab 7)(re)start mining progress.$(tput sgr 0)"
echo "$(tput setaf 1)mstop $(tput setab 7)close mining progress.$(tput sgr 0)"
echo "$(tput setaf 1)mrecovery $(tput setab 7)restore everything to default.$(tput sgr 0)"
echo "$(tput setaf 1)mupdate $(tput setab 7)update miners, clients. (Auto update only starts on boot)$(tput sgr 0)"
echo "$(tput setaf 1)mreconf $(tput setab 7)simulate first boot: configure DHCP, creating fake dummy$(tput sgr 0)"
echo "$(tput setaf 1)mhelp $(tput setab 7)this screen.$(tput sgr 0)"
