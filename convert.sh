#!/bin/bash
# This script should take a smartboard notebook file, extract it to a temp dir, convert the svg's to png, and compile them into pdf
# Depends on imagemagick, unzip
# Note, must add "File:///users/username/.temp/SmartConvert/extracteddir/" before symbolic links in svg before conversion or imagemagic will not recognized embedded images
mkdir ~/.temp/SmartConvert/

#ask for directory (pass through as arguement?) in which .notebook files are in

#For loop for each .notebook file

#Extract .notebook to temp dir

#Remove "/annotationmetadata" "assessment.xml" "metadata.db" "metadata.rdf" "metadata.xml" "preview.png" "settings.xml" from folder

#rename svg files using imsmanifest to reflect page order (errr not sure how I'm going to implement this)

#batch convert .svg to png (bmp?) and compile to pdf (preserving name of folder) using imagemagick

#copy file to original direcotry "/PDF Files" 

#delete directory in temp/smartconvert

#loop


echo "All done! Deleting temporary files."
rm -rf ~/.temp/SmartConvert/
