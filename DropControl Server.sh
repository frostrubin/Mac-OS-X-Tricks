#!/bin/bash 

# This script takes terminal commands from the 
# "input.txt" file, executes them and writes the output into
# "output.txt".

# It is most usable, if the monitored "input.txt" file resides in
# a folder that is synced via Dropbox.
# This way, i can remote control a computer via Dropbox.
 
homepath="~/Dropbox/Scripts/dropcontrol/"
while true; do 
 
	if [ -s ${homepath}input.txt ] && [ -f ${homepath}input.txt ];then
		OUTCOM=$(cat ${homepath}input.txt)
		$OUTCOM > ${homepath}output.txt
		rm ${homepath}input.txt > /dev/null 2>&1
		else
			sleep 10
	fi
done