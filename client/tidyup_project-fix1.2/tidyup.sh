#!/bin/bash
clear
cd tidyup-components
read < current.version version
cd ..
echo "Welcome to BPI-Cleaner v$version by TechnikAmateur
Press Enter to continue"; read
if (( $EUID != 0 ))
then
    echo "Please run as superuser"
    exit 1
fi
echo "Do you want to check for updates? (recommended) Y/n"; read runupdater
if [ "$runupdater" != "n" ]
then
    cd tidyup-components
    wget -N -q http://technikamateur.bplaced.net/tidyup/"$version"/tidyupdate.sh
    chmod a+x tidyupdate.sh
    ./tidyupdate.sh
    if [ -e update.done ]
    then
        rm -f update.done
        exit 2
    fi
fi
clear
echo "Updating package list...please wait"
echo
#apt-get update
echo
echo "Now ready to clean."
echo
echo "Do you want to clean? Y/n"; read clean
if [ "$clean" == "n" ]
then
    echo "canceling opertaion..."
    sleep 1
    exit 1
else
    echo "cleaning, might take some time!"
fi
#apt-get autoremove -y --quiet
#apt-get clean -y --quiet
echo
echo "successfully completed.
Thanks for using BPI-Cleaner!"
exit 2