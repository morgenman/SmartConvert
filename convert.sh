#!/bin/bash
# This script should take a smartboard notebook file, extract it to a temp dir, convert the svg's to png, and compile them into pdf
# Depends on imagemagick, unzip
# Note, must add "File:///users/username/.temp/SmartConvert/extracteddir/" before symbolic links in svg before conversion or imagemagic will not recognized embedded images
rm -rf ~/.temp/SmartConvert/ #REMOVE LATER FOR DEBUG PURPOSES ONLY
mkdir ~/.temp/SmartConvert/

#ask for directory (pass through as arguement?) in which .notebook files are in
echo Enter the directory containing notebook file:
#Note, you cannot drag a directory on the script, will not accept '/home/...' only /home/ 
#Furthermore, no parent directories allowed to have spaces in them
read DIR
#$DIR is directory containing files
#cd $DIR
cd /home/koru/Cole

#For loop for each .notebook file
find . -name "*.notebook" -type f -exec cp {} ~/.temp/SmartConvert/ \;
#Extract .notebook to temp dir
cd ~/.temp/SmartConvert/
for file in *.notebook
do
 mv "$file" "${file%.notebook}.zip"
done

for f in *.*; do
  dir=${f%.zip}

  unzip -d "./$dir" "./$f"
  rm "$f"
done
#Recursive commands for each directory
for D in *; do
    if [ -d "${D}" ]; then
        echo "looping  --  ${D}"   #for debug purposes
        cd ~/".temp/SmartConvert/${D}/"
        echo changed to $D
        echo > Youareintherightdir.txt
	    #rename svg files using lmsmanifest to reflect page order (errr not sure how I'm going to implement this)
	    i=0
        while read filename; do
            mv $filename file$i.svg
            let i++
        done < <(xpath -q -e '//resource[@identifier="group0_pages"]/file/@href' ~/.temp/SmartConvert/"${D}"/imsmanifest.xml | cut -d\" -f2)
	    #remove excess files

	    #batch convert .svg to png (bmp?) and compile to pdf (preserving name of folder) using imagemagick
        
	    #copy file to original direcotry "/PDF Files" 
        cd ~/".temp/SmartConvert/"
        echo "changed to temp folder (looping\)"

    fi
done


#loop

#delete directory in temp/smartconvert
echo "All done! Deleting temporary files."
#rm -rf ~/.temp/SmartConvert/