#!/bin/bash
BOTFILE=$1
echo 'Bot starting in 60 seconds...'
sleep $((5 + RANDOM % 45))
if [ -f /home/container/package.json ]; then npm install; fi;
node ${BOTFILE}
