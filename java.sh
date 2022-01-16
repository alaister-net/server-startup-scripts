#!/bin/bash

OPTS=`getopt -l memory:,file:,repo:,branch:,shell:,auto-pull: -n 'parse-options' -- "$@"`

if [ $? != 0 ]; then
    echo "Failed parsing options! Exiting..."
    exit 1
fi

eval set -- "$OPTS"

MEMORY=""
FILE=""
REPO=""
BRANCH=""
SHELL=""
AUTO_PULL=""

while true; do
    case "$1" in
        --memory ) MEMORY="$2"; shift 2;;
        --file ) FILE="$2"; shift 2;;
        --repo )
            if [[ $2 != --* ]]; then
                REPO="$2"
                shift
            fi
            shift
            ;;
        
        --branch )
            if [[ $2 != --* ]]; then
                BRANCH="$2"
                shift
            fi
            shift
            ;;
        
        --shell ) SHELL="$2"; shift 2;;
        --auto-pull ) AUTO_PULL="$2"; shift 2;;
        -- ) shift; break;;
        * ) break;;
    esac
done

wget -nv -O /home/container/start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash /home/container/start-app "$REPO" "$BRANCH" $SHELL $AUTO_PULL

echo "Starting app..."
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar $FILE
