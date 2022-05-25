#!/bin/bash

while [ ! -z "$1" ]; do
    case "$1" in
        --memory ) MEMORY="$2"; shift 2;;
        --file ) FILE="$2"; shift 2;;
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
        --auto-pull ) AUTO_PULL="$2"; shift 2;;
        -- ) shift; break;;
        * ) break;;
    esac
done

cat << EOF
* Memory: $MEMORY
* Bot File: $FILE
* Git Repo: $REPO
* Git Branch: $BRANCH
* Enable Shell: $SHELL
* Auto Pull: $AUTO_PULL
EOF

wget -nv -O /tmp/start-app https://github.com/alaister-net/server-startup-scripts/raw/master/app.sh
bash /tmp/start-app "$REPO" "$BRANCH" $SHELL $AUTO_PULL

echo "Starting app..."
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar $FILE
