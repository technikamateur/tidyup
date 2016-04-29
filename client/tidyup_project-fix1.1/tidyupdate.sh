#!/bin/bash
clear
echo "Checking for Updates..."
sleep 2
echo
wget -N -q http://technikamateur.bplaced.net/tidyup/1+1/check.upgrade
read <check.upgrade cupgrade
read <current.version cversion
echo "Latest Version $cupgrade
Your version $cversion"
echo
if [ "$cupgrade" == "$cversion" ]
then
    echo "You have got the latest version."
    sleep 3
    exit 1
elif [ "$cupgrade" > "$cversion" ]
then
    echo "Update available"
    echo
    wget -N -q http://technikamateur.bplaced.net/tidyup/1.2/tidyup.sh
    cd ..
    odir="$PWD"
    cd tidyup-components
    echo "done" > update.done
    echo "$cupgrade" > current.version
    mv tidyup.sh "$odir"/
    cd ..
    chmod a+x tidyup.sh
    echo
    echo "Update done ;)"
    exit 1
else 
    echo "Error."
    exit 2
fi