#!/bin/bash

OPTS=`getopt -l file:,requirements:,repo:,branch:,shell:,auto-install:,auto-pull: -n 'parse-options' -- "$@"`

if [ $? != 0 ]; then
    echo "Failed parsing options! Exiting..."
    exit 1
fi

eval set -- "$OPTS"

FILE=""
REQUIREMENTS=""
REPO=""
BRANCH=""
SHELL=""
AUTO_INSTALL=""
AUTO_PULL=""

while true; do
    case "$1" in
        --file ) FILE="$2"; shift 2;;
        --requirements ) REQUIREMENTS="$2"; shift 2;;
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
        --auto-install ) AUTO_INSTALL="$2"; shift 2;;
        --auto-pull ) AUTO_PULL="$2"; shift 2;;
        -- ) shift; break;;
        * ) break;;
    esac
done

wget -nv -O /home/container/start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash /home/container/start-app "$REPO" "$BRANCH" $SHELL $AUTO_PULL


if [ -f ${REQUIREMENTS} ] && [  $AUTO_INSTALL != "no" ]; then
    if [ $AUTO_INSTALL == "ask" ]; then
        echo "** pip requirements file detected. Continue to install/upgrade from it? [Enter yes or no] **"
        echo "Hint: You can now hide this prompt by setting the default value on the 'Startup' page."
        read confirm
        case $confirm in
            [Yy]* )
                echo "Installing/upgrading packages..."
                pip3 install -U --prefix .local -r $REQUIREMENTS
                ;;
            * ) echo "Skipped!";;
        esac
    else
        pip3 install -U --prefix .local -r $REQUIREMENTS
    fi
fi

echo "Starting app..."
python3 $FILE
