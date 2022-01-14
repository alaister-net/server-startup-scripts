#!/bin/bash

MEMORY=$1
JAR_FILE=$2
GIT_BRANCH=$3
GIT_REPO=$4

wget -nv -O ./start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash ./start-app "$GIT_BRANCH" "$GIT_REPO"

java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar $JAR_FILE
