#!/bin/bash
setupversion=1.0
clear
echo "Welcome to BPI-Cleaner by TechnikAmateur"
echo "Press Enter to continue with installation"; read
if (( $EUID != 0 ))
then
    echo "Please run as root or sudo"
    exit 1
fi
wget -N http://technikamateur.bplaced.net/tidyup/1+1/tidyup.sh
chmod a+x tidyup.sh
sleep 1
mkdir tidyup-components
cd tidyup-components
wget -N http://technikamateur.bplaced.net/tidyup/1+1/tidyupdate.sh
chmod a+x tidyupdate.sh
sleep 1
clear
echo "$setupversion" > current.version
echo "Everything done! You can delete this file now.
report errors technikamateur@gmx.de
Thanks a lot"
exit 1