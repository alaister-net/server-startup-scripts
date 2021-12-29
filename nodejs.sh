#!/bin/bash
BOTFILE=$1
GITBRANCH=$2
GITREPO=$3
NODE_DEPENDS=''
if [ -f .node_depends ]; then
    NODE_DEPENDS=`< .node_depends`
    if [[ ${NODE_DEPENDS} =~ [!?#%{}$\\[\\]|\"\\_^] ]]; then
        echo 'Invalid characters detected in .node_depends files. Please fix it. Exiting script...'
        exit 1
    fi
    rm .node_depends
fi
if [ -d .git ]; then
    if [ -f .git/config ]; then
        ORIGIN=$(git config --get remote.origin.url)
        if [ ! -z "${ORIGIN}" ]; then
            echo ".git config detected. Pulling from '${ORIGIN}'..."
            git pull --ff-only
        fi
    fi
elif [ ! -z ${GITREPO} ]; then
    if [[ ${GITREPO} != *.git ]]; then
        GITREPO=${GITREPO}.git
    fi
    echo -e "By cloning a Git repo, all existing files will be deleted. Continue? [Enter yes or no]"
    read confirm
    case $confirm in
        [Yy]* )
            rm -rf ..?* .[!.]* *
            echo -e "/home/container is now empty. Cloning '${GITBRANCH}' from '${GITREPO}'..."
            git clone --single-branch --branch ${GITBRANCH} ${GITREPO} .
            echo -e "Finished cloning '${GITBRANCH}' from '${GITREPO}' into /home/container!"
            ;;
        * ) echo "Exiting script..."; exit;;
    esac
fi
if [ -f package.json ]; then npm i; fi;
if [ ! -z "${NODE_DEPENDS}" ]; then npm i ${NODE_DEPENDS}; fi;
node ${BOTFILE}
