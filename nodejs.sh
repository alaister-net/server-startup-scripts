#!/bin/bash

BOT_FILE=$1
GIT_BRANCH=$2
GIT_REPO=$3

wget -nv -O ./start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash ./start-app "$GIT_BRANCH" "$GIT_REPO"

MANAGER="npm"
echo "Please choose a node package manager: [Enter the integer]"
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
    * ) echo "Using npm";;
esac

if [ -f package.json ]; then
    echo "package.json detected. Continue to install/upgrade from package.json? [Enter yes or no]"
    read confirm
    case $confirm in
        [Yy]* )
            echo "Installing/upgrading packages..."
            eval $MANAGER "install"
            ;;
        * ) echo "Skipped installing/upgrading packages!";;
    esac
fi

node $BOT_FILE
