#! /usr/bin/env bash
#
# remove_duplicate_files_with_paren1paren.sh

# This is a command-line Bash script to remove all files that contain:  (1).jpg
# e.g., IMG_0375 (1).jpg. The script takes in 1 command-line parameter, 
# directory_path, the location where the duplicate files exist.
#
# Note: Script processes only a single directory. 
#
# Kim Lew

#test_directory_name="/Users/kimlew/Sites/bash_projects/test_run"
#directory_path=/Users/kimlew/Documents/PHOTOS/2019/iPhone_photos_2019-Jan-01-Jul-30

echo "Type the directory path where the duplicate files are: "
read directory_path
echo "You typed: " $directory_path

if [ ! -d $directory_path ] 
then
    echo "This directory does NOT exist." 
    exit 9999 # die with error code 9999
fi

find $directory_path -type f -name '*(1).jpg' | # -delete |
sort > files_deleted.txt

echo 'Pause and LOOK at: files_deleted.txt. VERIFY these are the files to delete.'
sleep 5s

read -r -p 'If these are the files you want to delete, type Y: ' response
response=${response,,}    # tolower
if [[ "$response" =~ ^(Y|y|yes)$ ]]
then
    cat files_deleted.txt | 
    while read a_file_name; do
      # Deletes each file, 1 at a time, as listed in files_deleted.txt.
      rm "$a_file_name" # Note: Use double quotes when spaces might be in filenames.
    done
    echo "The files have been removed."
else
    echo "Program exited." 
    exit 9999 # die with error code 9999
fi

exit 0
