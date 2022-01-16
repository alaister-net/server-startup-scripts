#!/bin/bash

while [ ! -z "$1" ]; do
    case "$1" in
        --file ) FILE="$2"; shift 2;;
        --requirements ) REQUIREMENTS="$2"; shift 2;;
        --repo )
            if [[ $2 != --* ]]; then
                REPO="$2"
                shift
            else
                REPO=""
            fi
            shift
            ;;
        
        --branch )
            if [[ $2 != --* ]]; then
                BRANCH="$2"
                shift
            else
                BRANCH=""
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

echo "* Bot File: ${FILE}"
echo "* Requirements File: ${REQUIRMENTS}"
echo "* Git Repo: ${REPO}"
echo "* Git Branch: ${BRANCH}"
echo "* Enable Shell: ${SHELL}"
echo "* Auto Install: ${AUTO_INSTALL}"
echo "* Auto Pull: ${AUTO_PULL}"

wget -nv -O /home/container/start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash /home/container/start-app "$REPO" "$BRANCH" $SHELL $AUTO_PULL


if [ -f $REQUIREMENTS ] && [  "$AUTO_INSTALL" != "no" ]; then
    if [ "$AUTO_INSTALL" == "ask" ]; then
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
