#!/bin/bash
#
# tidyup - a linux shell program to clean your Banana Pi and Raspberry Pi.
# Copyright (C) 2016  Daniel Körsten (contact: technikamateur@gmx.de)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# version
version="1.5"
wai=$(dirname "$(readlink -e "$0")")
internet=true
# main
clear
echo "Welcome to tidyup v$version by TechnikAmateur
Press Enter to continue"; read
if [[ $EUID != 0 ]]; then
  echo "Please run as superuser"
  exit 1
fi
echo
# checking directory
if ! [[ "$wai" == "/usr/local/bin" ]]; then
  echo "Copying to /usr/local/bin"
  echo 'Start script using "tidyup" wherever you are'
  cp tidyup.sh /usr/local/bin
  rm tidyup.sh
  cd /usr/local/bin
  cp tidyup.sh tidyup
  chmod 755 tidyup
  rm tidyup.sh
  exit 0
fi
# checking for curl
if ! [[ -f /usr/bin/curl ]]; then
  echo -e "We need to install curl first... (please wait)"
  apt-get update > /dev/null && apt-get install -y curl
  echo
fi
# checking for update
echo "Checking for Updates..."
curl -s --request GET https://raw.githubusercontent.com/technikamateur/tidyup/master/update.info || $internet=false
if [[ $internet == true ]]; then
  wget -N -q https://raw.githubusercontent.com/technikamateur/tidyup/master/update.info
  lversion="$(cat update.info)"
  if [[ $lversion != $version ]]; then
    clear
    echo "Updating..."
    wget -N -q https://github.com/technikamateur/tidyup/releases/download/$lversion/tidyup.sh
    cp --remove-destination tidyup.sh tidyup
    chmod 755 tidyup
    rm tidyup.sh update.info > /dev/null
    echo "Please restart script!"
    exit 0
  else
    rm update.info > /dev/null
  fi
else
  rm update.info > /dev/null
  echo "Connection to server failed! Are you online?"
fi
# if no update than clean
echo
echo "Do you want to clean? Y/n"; read clean
if [[ "$clean" == "n" ]]; then
    echo "canceling opertaion..."
    exit 1
else
    echo "cleaning, might take some time!"
fi
apt-get autoremove -y > /dev/null
apt-get clean -y > /dev/null
rm -rf /var/lib/apt/lists/* > /dev/null
echo "done! Updating package list..."
apt-get update > /dev/null
clear
echo "successfully completed.
Thanks for using tidyup by TechnikAmateur!"
exit 0
