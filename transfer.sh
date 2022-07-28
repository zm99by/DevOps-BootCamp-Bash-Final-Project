#!/bin/bash
#set -x
currentVersion="1.4.0"

singleUpload()
{
  for file in $@
  do
  echo "Uploading $file"
  response=$(curl --progress-bar --upload-file "$1" "https://transfer.sh/$file") || { echo "Failure!"; return 1;}
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

case $@ in
  -v)
    echo "$currentVersion" && exit
    ;;
  -h)
    Help && exit
    ;;
  -d)
    singleDowload "$@" && exit
    ;;
esac

singleUpload "$@" || exit 1
printUploadResponse

# $ curl https://transfer.sh/1lDau/test.txt -o test.txt
# ./transfer.sh -d ./test Mij6ca test.txt