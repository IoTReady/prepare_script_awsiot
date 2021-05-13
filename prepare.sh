#!/bin/bash

# Note: This script uses https://github.com/igrr/mkspiffs to build and upload SPIFFS image
# exit on error
set -e

echo -e 'Updating software from git\n'

git stash
git pull

echo -e 'Preparing new device\n'

python3 ./registerDevice.py

make -C source

if [ ! -f source/build/include/sdkconfig.h ]; then
    echo "'sdkconfig.h' not found, build your firmware first"
    exit 1
fi

# Copy project sdkconfig to mkspiffs
grep "CONFIG_SPIFFS_"  source/build/include/sdkconfig.h  > source/components/mkspiffs/include/sdkconfig.h
# make -C source/components/mkspiffs clean
make -C source/components/mkspiffs
make -C source makefs
make -C source flashfs
make -C source flash

echo
echo "=========================="
echo
echo "MAC Address:"
echo
cat mac_address.txt
echo
echo "=========================="
echo
echo -e "All done! On to the next one :-)\n"


