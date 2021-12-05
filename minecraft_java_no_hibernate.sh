#!/bin/bash
MEMORY=$1
JARFILE=$2
rm -f ./plugins/anet.jar ./plugins/alaister_net_hibernate.jar
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
