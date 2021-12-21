#!/bin/bash
FILE=$1
if [ ! -f "$FILE" ]; then
    RANDVERSION=$(echo $((1 + $RANDOM % 4000)))
    curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" -H "Accept-Language: en" -H "Accept-Encoding: gzip, deflate" -o versions.html.gz https://www.minecraft.net/en-us/download/server/bedrock
    DOWNLOAD_URL=$(zgrep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' versions.html.gz)
    DOWNLOAD_FILE=$(echo ${DOWNLOAD_URL} | cut -d"/" -f5)
    rm versions.html.gz
    curl -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" -H "Accept-Language: en" -o $DOWNLOAD_FILE $DOWNLOAD_URL
    unzip -qq -o $DOWNLOAD_FILE
    rm $DOWNLOAD_FILE
fi
chmod +x ./${FILE}
./${FILE}
