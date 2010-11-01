#!/bin/bash
 
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in $(ls /System/Library/Speech/Voices/);do
 
voice=`echo ${i%\.*}`
 
echo $voice
case "$voice" in
"BadNews")
voice="Bad";
;;
"GoodNews")
voice="Good";
;;
"Organ")
voice="Pipe";
;;
esac
 
say -v $voice "The cake is a lie."
done
IFS=$SAVEIFS