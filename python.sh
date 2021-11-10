#!/bin/bash
BOTFILE=$1
REQUIREMENTFILE=$2
echo 'Bot starting in 60 seconds...'
sleep $((5 + RANDOM % 55))
if [ -f /home/container/${REQUIREMENTFILE} ]; then pip3 install -U --prefix .local -r ${REQUIREMENTFILE}; fi;
python3 ${BOTFILE}
