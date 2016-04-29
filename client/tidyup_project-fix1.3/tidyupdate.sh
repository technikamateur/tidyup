#!/bin/bash
clear
echo "Welcome to tidyup! Updater is running..."
echo
sleep 2
echo "Downloading upgrade...might take some time."
sleep 1
cd tidyup-components
read <current.version cversion
read <check.upgrade cupgrade
echo "Latest Version $cupgrade
Your version $cversion"
echo
if [ ! -e update.ready ]
then
    echo "Error '02'. See https://github.com/technikamateur/tidyup for details."
fi
cd ..
sleep 2
wget -N http://technikamateur.bplaced.net/tidyup/"$cupgrade"/tidyup.sh
chmod a+x tidyup.sh
sleep 1
cd tidyup-components
echo "$cupgrade" > current.version
cd ..
echo
echo "Update done."
exit 1