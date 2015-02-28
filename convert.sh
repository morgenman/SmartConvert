#!/bin/bash
# This script should take a smartboard notebook file, extract it to a temp dir, convert the svg's to png, and compile them into pdf
# Depends on imagemagick, unzip, libxml-xpath-perl
# Note, must add "File:///home/username/.temp/SmartConvert/extracteddir/" before symbolic links in svg before conversion or imagemagic will not recognized embedded images
rm -rf ~/.temp/SmartConvert/ #REMOVE LATER FOR DEBUG PURPOSES ONLY
mkdir ~/.temp/SmartConvert/

#ask for directory (pass through as arguement?) in which .notebook files are in
echo Enter the directory containing notebook file:
#Note, you cannot drag a directory on the script, will not accept '/home/...' only /home/ 
#Furthermore, no parent directories allowed to have spaces in them
read DIR
echo Enter your username:
read USR
#$DIR is directory containing files
cd $DIR

#move all notebook files to temp dir
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
        #echo "looping  --  ${D}"   #for debug purposes
        cd ~/".temp/SmartConvert/${D}/"
        #echo > Youareintherightdir.txt
	    #rename svg files using lmsmanifest to reflect page order (errr not sure how I'm going to implement this)
	    i=10
        while read filename; do
            mv $filename file$i.svg
            let i++
        done < <(xpath -q -e '//resource[@identifier="group0_pages"]/file/@href' ~/.temp/SmartConvert/"${D}"/imsmanifest.xml | cut -d\" -f2)
	    
	    #fix svg's to include linked pictures 
	    pth="file:///home/$USR/.temp/SmartConvert/${D}/images"
	    #echo $pth
	    find "/home/$USR/.temp/SmartConvert/${D}" -type f -exec sed -i "s+images+$pth+g" {} \;
	    
	    #batch convert .svg to png (bmp?) and compile to pdf (preserving name of folder) using imagemagick
        ls file*.svg | sort -n | tr '\n' ' ' | sed "s+$+\ '${D}'.pdf+" | xargs convert
        
	    #copy file to original direcotry "/PDF Files" 
	    cp "${D}.pdf" "$DIR/${D}.pdf"
	    
        cd ~/".temp/SmartConvert/"
        #echo "changed to temp folder (looping\)"

    fi
done



#delete directory in temp/smartconvert
echo "All done! Deleting temporary files."
echo "PDF files will be located in $DIR"
rm -rf ~/.temp/SmartConvert/