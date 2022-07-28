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

#printUploadResponse()
#{
#fileID=$(echo "$response" | cut -d "/" -f 4)
#  cat <<EOF
#Transfer File URL: $response
#EOF
#}

singleDowload() {
  echo Downloading "$4"
  curl --progress-bar https://transfer.sh/"$2"/"$3" -o "$3"
  echo "Success!"
}

Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
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
printUploadResponse