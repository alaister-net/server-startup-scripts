#!/bin/bash
MEMORY=$1
JARFILE=$2
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
