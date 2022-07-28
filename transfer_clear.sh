#!/bin/bash
#set -x
# This script to upload files from terminal to https://transfer.sh 
currentVersion="1.23.0"

singleUpload()
{
  for i in "$@"; do
    file=$i
    echo "\n Uploading $i"
    response=$(curl --progress-bar --upload-file "$1" "https://transfer.sh/$file") || { echo -e "\033[31m Failure!\033[37m"; return 1;}
    echo -e "\033[32m Transfer File URL: ""$response"" \n" 
  done
}

printUploadResponse()
{
fileID=$(echo "$response" | cut -d "/" -f 4)
  cat <<EOF
Transfer File URL: $response
EOF
}

singleDowload() {
  curl https://transfer.sh/$2/$3 -o $3
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