#!/bin/bash
# This work is licensed under the Creative Commons Attribution 4.0 International License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/
# or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
# setting up some basic parameters
version="1.5"
wai=$(dirname "$(readlink -e "$0")")
internet=true
# main
clear
echo "Welcome to tidyup v$version by TechnikAmateur
Press Enter to continue"; read
if (( $EUID != 0 ))
then
    echo "Please run as superuser"
    exit 1
fi
echo
# checking directory
if ! [ "$wai" == "/usr/local/bin" ]
then
    echo "Copying to /usr/local/bin"
    echo 'Start script using "tidyup" wherever you are'
    cp tidyup.sh /usr/local/bin
    rm tidyup.sh
    cd /usr/local/bin
    cp tidyup.sh tidyup
    chmod a+x tidyup
    rm tidyup.sh
    exit 1
fi
# checking for curl
if ! [ -f /usr/bin/curl ]
then
        echo -e "We need to install curl first... (please wait)"
        apt-get update && apt-get install -y curl
        echo
fi
# checking for update
echo "Checking for Updates..."
curl -s --request GET http://technikamateur.bplaced.net/tidyup/check.php?userversion=$version || $internet=false
if [ $internet == true ]
then
  update=$(curl -s --request GET http://technikamateur.bplaced.net/tidyup/check.php?userversion=$version)
  if [ "$update" == "latest-version" ]
  then
      echo "You have got the latest-version!"
  else
      wget -N -q $update/tidyup.sh
      echo "Updating..."
      cp --remove-destination tidyup.sh tidyup
      chmod a+x tidyup
      rm tidyup.sh
      echo "Please restart script!"
      exit 1
  fi
else
  echo "Connection to server failed! Are you online?"
fi
# if no update than clean
echo
echo "Do you want to clean? Y/n"; read clean
if [ "$clean" == "n" ]
then
    echo "canceling opertaion..."
    exit 1
else
    echo "cleaning, might take some time!"
fi
apt-get autoremove -y --quiet
apt-get clean -y --quiet
rm -rf /var/lib/apt/lists/*
echo "done! Updating package list..."
sleep 2
apt-get update
clear
echo "successfully completed.
Thanks for using tidyup by TechnikAmateur!"
exit 1
