#!/bin/bash
# This code loops over all .app Applications that reside in the folders defined in the "folders" array (below).
# The Icons are copied into a new folder, converted to png and
# if imagemagick is present, a tile of all applications is created.

# After the initial run, the "icns" folder and the "png" folder can be deleted.
# Empty the "folders" array in the coding and in the "smallpng" folder, only reatain
# icons that you like. The result:
# A nice tile of icons! I am using it for my Applications Stack in the Dock.


#The Slash at the end of folder names is important!!
folders=(  "/Applications/" "/Applications/Utilities/" "/pub/Applications/" "/Developer/Applications/" 
           "/Developer/Applications/Audio/" "/Developer/Applications/Graphics\ Tools/" 
           "/Developer/Applications/Performance\ Tools/" "/Developer/Applications/Utilities/" )
           
iconfolder="/Users/bernhard/Desktop/AppIconFolder/"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for folder in ${folders[@]}; do
   mkdir -p ${iconfolder}icns
   mkdir -p ${iconfolder}png
   mkdir -p ${iconfolder}smallpng
 
   for i in $(ls "$folder"|grep ".app");do
      echo "$i"
      plistfile=`cat ${folder}${i}/Contents/Info.plist`
      iconname=`echo "$plistfile"|grep -A 1 "CFBundleIconFile" | \
                sed -n '/<string>/,/<\/string>/p;'| \
                sed 's/<string>//g;s/<\/string>//g'`
      iconname=`echo ${iconname//[[:space:]]}`
      iconname=`echo ${iconname}|sed 's/.icns//g'`
      iconfile=`echo ${iconname}.icns`
 
      cp "${folder}${i}/Contents/Resources/${iconfile}"   \
         "${iconfolder}icns/${i%.*}.icns"
   done
done

#cp ${iconfolder}png/* ${iconfolder}smallpng/
for i in $(ls "${iconfolder}icns"|grep ".icns");do
   #convert -resize 128x128 "${iconfolder}smallpng/${i}" \
   #                        "${iconfolder}smallpng/${i}"
   sips -s format png ${iconfolder}icns/${i} \
        --out ${iconfolder}png/${i%.*}.png
   sips -i ${iconfolder}png/${i%.*}.png
   sips -z 128 128 ${iconfolder}png/${i%.*}.png --out ${iconfolder}smallpng/${i%.*}.png /dev/null
done
 
filecount=`ls -l "${iconfolder}smallpng" | wc -l`
filecount=`echo ${filecount//[[:space:]]}`
filecount=$(($filecount-1))
 
if [ "$filecount" -le 4 ];then
   tiling="2x2"
elif [ "$filecount" -le 9 ];then
   tiling="3x3"
elif [ "$filecount" -le 16 ];then
   tiling="4x4"
elif [ "$filecount" -le 25 ];then
   tiling="5x5"
elif [ "$filecount" -le 36 ];then
   tiling="6x6"
elif [ "$filecount" -le 49 ];then
   tiling="7x7"
elif [ "$filecount" -le 64 ];then
   tiling="8x8"
elif [ "$filecount" -le 81 ];then
   tiling="9x9"
elif [ "$filecount" -le 100 ];then
   tiling="10x10"
else
   tiling="x1"
fi
 
montage -geometry +0+0 -tile $tiling -background none \
        ${iconfolder}smallpng/*.png \
        ${iconfolder}tile.png
IFS=$SAVEIFS