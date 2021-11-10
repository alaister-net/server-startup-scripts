#!/bin/bash
MEMORY=$1
JARFILE=$2
echo 'Server starting in 60 seconds...'
sleep $((5 + RANDOM % 55))
curl --create-dirs -sL -o ./plugins/anet.jar https://api.spiget.org/v2/resources/4441/download
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
