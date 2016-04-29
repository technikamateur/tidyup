#!/bin/bash
setupversion=1.2
clear
echo "Welcome to BPI-Cleaner v$setupversion by TechnikAmateur"
echo "Press Enter to continue with installation"; read
if (( $EUID != 0 ))
then
    echo "Please run as superuser"
    exit 1
fi
wget -N http://technikamateur.bplaced.net/tidyup/"$setupversion"/tidyup.sh
chmod a+x tidyup.sh
sleep 1
mkdir tidyup-components
cd tidyup-components
wget -N http://technikamateur.bplaced.net/tidyup/"$setupversion"/tidyupdate.sh
chmod a+x tidyupdate.sh
sleep 1
clear
echo "$setupversion" > current.version
echo "Everything done! You can delete this file now.
report errors to: technikamateur@gmx.de
Thanks a lot"
exit 1