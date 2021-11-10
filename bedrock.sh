#!/bin/bash
FILE=$1
echo 'Server starting in 60 seconds...'
sleep $((5 + RANDOM % 55))
chmod +x ./${FILE}
./${FILE}
