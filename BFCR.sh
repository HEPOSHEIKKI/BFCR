#!/bin/bash

Help()
{
	echo "Bash File Content Replace | BFCR"
	echo
	echo "Replace the contents of EVERY file in a directory with the contents of an input file"
	echo
	echo
	echo "Arguments"
	echo
	echo "-d	Set the directory to edit"
	echo "-f	Set the input file"
	echo "-h	Print out this help message"
	echo
	echo
	echo "This script can be run without arguments"

	exit 1
}

while getopts d:f:h flag; do
    case "${flag}" in
        f) mainFile=${OPTARG};;
        d) editDir=${OPTARG};;
	h) Help;;
    esac
done

if [[ -v editDir ]]
then
	echo $editDir
	:
else
	read -p 'Directory to edit: ' editDir
fi
if [[ -v mainFile ]]
then
	echo $mainFile
	:
else
	read -p 'File to use and rename: ' mainFile
fi
printf "\033[0;31mALL FILES IN \033[0m$editDir\033[0;31m WILL BE OVERWRITTEN. THIS CANNOT BE UNDONE!\033[0m\n"
read -p 'Continue? :' continueyn
echo $continueyn
if [ ${continueyn^^} != "Y" ]
then
	printf "Aborting, user chose not to continue.\n"
	exit 1
fi
for file in ${editDir%/}/*
do
	cat $mainFile > $file
	printf "\033[1;33m[INFO]\033[0m $file\033[0K\r"
done
printf "\n"
echo "Done!"
exit 1
