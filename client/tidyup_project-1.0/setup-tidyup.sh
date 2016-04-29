#!/bin/bash
clear
echo "Welcome to bpi-cleaner by TechnikAmateur"
echo "Press Enter to continue with installation"; read

if (( $EUID != 0 ))
then
    echo "Please run as root or sudo"
    exit 1
fi
wget -N http://technikamateur.bplaced.net/tidyup/current.version
sleep 1
wget -N http://technikamateur.bplaced.net/tidyup/tidyupdate.sh
chmod a+x tidyupdate.sh
sleep 1
wget -N http://technikamateur.bplaced.net/tidyup/latest-version/tidyup.sh
chmod a+x tidyup.sh
sleep 1
clear
echo "Everything done! You can delete this file now.
report errors technikamateur@gmx.de
Thanks a lot"
exit 1