#!/bin/bash

GIT_BRANCH=$1
GIT_REPO=$2

shell_access () {
    while true
    do
        read -p "container@pterodactyl:/home/container$ " cmd
        if [ "$cmd" == "exit" ]; then
            break
        else
            eval "$cmd"
            sleep 1
        fi
    done
}

echo "Do you want to enable shell access mode? (for advanced users) [Enter yes or no]"
read confirm
case $confirm in
    [Yy]* )
        echo "Shell access mode enabled! Enter 'exit' to quit shell access mode."
        echo "Warning: terminal text editors and long running processes do not work in this mode."
        shell_access
        ;;
esac
echo "Shell access mode disabled! Starting your server normally...";

if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "${ORIGIN}" ]; then
            echo ".git config detected. Continue to pull from '${ORIGIN}'? [Enter yes or no]"
            read confirm
            case $confirm in
                [Yy]* )
                    echo "Pulling from '${ORIGIN}'..."
                    git pull --ff-only
                    ;;
                * ) echo "Skipped!";;
            esac
        fi
    fi
elif [ ! -z ${GITREPO} ]; then
    if [[ ${GITREPO} != *.git ]]; then
        GITREPO=${GITREPO}.git
    fi
    echo "By cloning a Git repo, all existing files will be deleted. Continue? [Enter yes or no]"
    read confirm
    case $confirm in
        [Yy]* )
            rm -rf ..?* .[!.]* *
            echo "/home/container is now empty. Cloning '${GITBRANCH}' from '${GITREPO}'..."
            git clone --single-branch --branch ${GITBRANCH} ${GITREPO} .
            ;;
        * ) echo "Skipped!";;
    esac
fi
