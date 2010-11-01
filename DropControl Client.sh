#!/bin/bash
 
# This script takes terminal commands from the 
# command line and writes them into the "input.txt" file.
# At the same time, the "output.txt" is monitored and 
# new content is displayed.

# It is most usable, if the filled "input.txt" file resides in
# a folder that is synced via Dropbox.
# This way, i can remote control a computer via Dropbox.

homepath="~/Dropbox/Scripts/dropcontrol/"
 
touch ${homepath}input.txt
touch ${homepath}output.txt
 
echo -n "Enter Command: "
read INCOM
 
echo "$INCOM" > ${homepath}input.txt
 
while [ -f ${homepath}input.txt ];do
	sleep 10
done
 
cat ${homepath}output.txt