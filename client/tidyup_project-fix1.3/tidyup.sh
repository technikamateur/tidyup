#!/bin/bash
clear #cleaning some files
if [ -e tidyupdate.sh ]
then
    rm tidyupdate.sh
elif [ -e setup-tidyup.sh ]
then
    rm setup-tidyup.sh
fi
cd tidyup-components
if [ -e update.ready ]
then
    rm update.ready
elif [ -e tidyupdate.sh ]
then
    rm tidyupdate.sh
fi #preparing update
read <current.version cversion
echo "Welcome to tidyup v$cversion by TechnikAmateur
Press Enter to continue"; read
if (( $EUID != 0 ))
then
    echo "Please run as superuser"
    exit 1
fi
echo
echo "Checking for Updates..."
echo
sleep 1
wget -N -q http://technikamateur.bplaced.net/tidyup/"$cversion"/check.upgrade
read <check.upgrade cupgrade
echo "Latest Version $cupgrade
Your version $cversion"
echo
cd ..
if [ "$cupgrade" == "$cversion" ]
then
    echo "You have got the latest version."
    sleep 2
elif [ "$cupgrade" > "$cversion" ]
then
    echo "Update available. Install now? (highly recommended) Y/n"; read runupdater
    if [ "$runupdater" != n ]
    then
        wget -N -q http://technikamateur.bplaced.net/tidyup/"$cupgrade"/tidyupdate.sh
        chmod a+x tidyupdate.sh
        cd tidyup-components
        echo "update" > update.ready
        cd ..
        echo "Run ./tidyupdate.sh"
        sleep 2
        exit 2
    fi
else
    echo "Error '01'. See https://github.com/technikamateur/tidyup for details."
fi
clear
echo "Ready to clean."
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
rm -rf /var/lib/apt/lists/*
apt-get update
apt-get autoremove -y --quiet
apt-get clean -y --quiet
clear
echo "successfully completed.
Thanks for using tidyup by TechnikAmateur!"
exit 2