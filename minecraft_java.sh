#!/bin/bash
MEMORY=$1
JARFILE=$2
rm -f ./plugins/anet.jar ./plugins/alaister_net_hibernate.jar
curl --create-dirs -sL -o ./plugins/alaister_net_hibernate.jar https://api.spiget.org/v2/resources/4441/download
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
