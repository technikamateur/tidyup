#!/bin/bash
setupversion=1.3
clear
echo "Welcome to BPI-Cleaner v$setupversion by TechnikAmateur"
echo "Press Enter to continue with installation"; read
if (( $EUID != 0 ))
then
    echo "Please run as superuser"
    exit 1
fi
clear
echo "    tidyup  Copyright (C) 2015  Daniel Körsten (contact: technikamateur@gmx.de)
    This program comes with ABSOLUTELY NO WARRANTY.
    This is free software, and you are welcome to redistribute it
    under certain conditions; see https://github.com/technikamateur/tidyup for details."
echo
echo "If you understand and accept the license agreement, press Enter"; read
clear
wget -N http://technikamateur.bplaced.net/tidyup/"$setupversion"/tidyup.sh
chmod a+x tidyup.sh
sleep 1
mkdir tidyup-components
cd tidyup-components
echo "$setupversion" > current.version
clear
echo "Everything done! Thanks a lot for installing!
Run ./tidyup.sh for cleaning."
exit 1