#!/bin/bash
#set -x
# This script to upload files from terminal to https://transfer.sh 
currentVersion="1.23.0"

singleUpload()
{
  for i in "$@"; do
    file=$i
    echo Uploading "$i"
    response=$(curl --progress-bar --upload-file "$1" "https://transfer.sh/$file") || { echo  Failure!; return 1;}
    echo Transfer File URL: "$response" 
  done
}

# printUploadResponse()
# {
# fileID=$(echo "$response" | cut -d "/" -f 4)
#  cat <<EOF
# Transfer File URL: $response
# EOF
# }

singleDowload() {
  if [[ ! -d "$2" ]]
      then
    mkdir -p $2
  fi
  echo Downloading "$4"
  curl --progress-bar https://transfer.sh/"$2"/"$3" -o "$2/$4"
  echo "Success!"
}

Help()
{
   # Display Help
   echo "Description: Bash tool to transfer files from the command line."
   echo "---------------------------------------------------------------"
   echo "Syntax: scriptTemplate [-d|h|v|]"
   echo "---------------------------------------------------------------"
   echo "-d     Download single file from the transfer.sh to the specified directory"
   echo "-h     Show the help"
   echo "-v     Print version"
   echo
}

if [[ $1 == "-v" ]]; then
  echo "$currentVersion" && exit
elif [[ $1 == "-h" ]]; then
  Help && exit
elif [[ $1 == "-d"* ]]; then
  singleDowload "$@" && exit
fi

singleUpload "$@" || exit 1
#printUploadResponse