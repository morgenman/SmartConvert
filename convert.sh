#!/bin/bash
# This script should take a smartboard notebook file, extract it to a temp dir, convert the svg's to png, and compile them into pdf
# Depends on imagemagick, unzip
# Note, must add "File:///users/username/.temp/SmartConvert/extracteddir/" before symbolic links in svg before conversion or imagemagic will not recognized embedded images
mkdir ~/.temp/SmartConvert/

#ask for directory (pass through as arguement?) in which .notebook files are in
echo Enter the directory containing notebook files
read DIR
#$DIR is directory containing files
cd $DIR

#For loop for each .notebook file
find . -name "*.notebook" -type f -exec cp {} "~/.temp/SmartConvert/" \;
#Extract .notebook to temp dir

#Remove "/annotationmetadata" "assessment.xml" "metadata.db" "metadata.rdf" "metadata.xml" "preview.png" "settings.xml" from folder

#rename svg files using lmsmanifest to reflect page order (errr not sure how I'm going to implement this)
#remove lmsmanifest

#batch convert .svg to png (bmp?) and compile to pdf (preserving name of folder) using imagemagick

#copy file to original direcotry "/PDF Files" 

#delete directory in temp/smartconvert

#loop


echo "All done! Deleting temporary files."
rm -rf ~/.temp/SmartConvert/
