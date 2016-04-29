#!/bin/bash
clear
echo "Welcome to bpi-cleaner by TechnikAmateur"
echo "Press Enter to continue"; read

if (( $EUID != 0 ))
then
    echo "Please run as root or sudo"
    exit 1
fi
wget -N -q http://technikamateur.bplaced.net/tidyup/tidyupdate.sh
chmod a+x tidyupdate.sh
echo "Do you want to check for updates? (recommended) j/n"; read runupdater
if [ "$runupdater" != "n" ]
then 
    ./tidyupdate.sh
    clear
else exit 1
fi
echo "Updating package list...please wait"
echo
#apt-get update
echo
echo "done"
echo "Do you want to clean? j/n"; read clean
if [ "$clean" == "n" ]
then
    echo "canceling opertaion..."
    exit 1
else
    echo "cleaning, might take some time!"
fi
#apt-get autoremove -y
#apt-get clean -y
echo "successfully completed
thanks for using bpi-cleaner"
exit 2