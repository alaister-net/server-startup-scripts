#!/bin/bash

OPTS=`getopt -l file:,repo:,branch:,manager:,shell:,auto-install:,auto-pull: -n 'parse-options' -- "$@"`

if [ $? != 0 ]; then
    echo "Failed parsing options! Exiting..."
    exit 1
fi

eval set -- "$OPTS"

FILE=""
REPO=""
BRANCH=""
MANAGER=""
SHELL=""
AUTO_INSTALL=""
AUTO_PULL=""

while true; do
    case "$1" in
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
        
        --manager ) MANAGER="$2"; shift 2;;
        --shell ) SHELL="$2"; shift 2;;
        --auto-install ) AUTO_INSTALL="$2"; shift 2;;
        --auto-pull ) AUTO_PULL="$2"; shift 2;;
        -- ) shift; break;;
        * ) break;;
    esac
done

wget -nv -O /home/container/start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash /home/container/start-app "$REPO" "$BRANCH" $SHELL $AUTO_PULL

if [ $MANAGER == "ask" ]; then
    echo "** Please choose a node package manager: [Enter the integer] **"
    echo "Hint: You can now hide this prompt by setting the default value on the 'Startup' page."
    echo "1) npm [default]"
    echo "2) yarn"
    echo "3) pnpm"
    read confirm
    case $confirm in
        2 )
            MANAGER="yarn"
            echo "Using yarn"
            ;;
        3 )
            MANAGER="pnpm"
            echo "Using pnpm"
            ;;
        * )
            MANAGER="npm"
            echo "Using npm"
            ;;
    esac
fi

if [ -f package.json ] && [ $AUTO_INSTALL != "no" ]; then
    if [ $AUTO_INSTALL == "ask" ]; then
        echo "** package.json detected. Continue to install/upgrade from package.json? [Enter yes or no] **"
        echo "Hint: You can now hide this prompt by setting the default value on the 'Startup' page."
        read confirm
        case $confirm in
            [Yy]* )
                echo "Installing/upgrading packages..."
                eval $MANAGER "install"
                ;;
            * ) echo "Skipped!";;
        esac
    else
        eval $MANAGER "install"
    fi
fi

echo "Starting app..."
node $FILE
