#!/bin/bash
clear
echo "Checking for Updates..."
sleep 2
echo
wget -N -q http://technikamateur.bplaced.net/tidyup/check.upgrade
read <check.upgrade cupdate
read <current.version cversion
echo "Latest Version $cupdate.$cupdate
Your version $cversion.$cversion"
echo
if [ "$cupdate" == "$cversion" ]
then
    echo "You have got the latest verion."
    exit 1
elif [ "$cupdate" > "$cversion" ]
then
    echo "Update available"
    echo
    wget -N -q http://technikamateur.bplaced.net/tidyup/latest-version/tidyup.sh
    chmod a+x tidyup.sh
    echo "Update done ;)"
    exit 1
fi