#!/bin/bash
MEMORY=$1
JARFILE=$2
echo 'Server starting in 60 seconds...'
sleep $((5 + RANDOM % 55))
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
