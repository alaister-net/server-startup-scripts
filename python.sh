#!/bin/bash

BOT_FILE=$1
REQUIREMENT_FILE=$2
GIT_BRANCH=$3
GIT_REPO=$4

wget -nv -O ./start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash ./start-app "$GIT_BRANCH" "$GIT_REPO"

if [ -f /home/container/${REQUIREMENT_FILE} ]; then
    echo "${REQUIREMENT_FILE} detected. Continue to install/upgrade from ${REQUIREMENT_FILE}? [Enter yes or no]"
    read confirm
    case $confirm in
        [Yy]* )
            echo "Installing/upgrading packages..."
            pip3 install -U --prefix .local -r ${REQUIREMENT_FILE}
            ;;
        * ) echo "Skipped!";;
    esac
fi

python3 $BOT_FILE
