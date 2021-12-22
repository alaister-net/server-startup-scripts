#!/bin/bash
MEMORY=$1
JARFILE=$2
echo 'eula=true' > ./eula.txt
rm -f ./plugins/anet.jar ./plugins/alaister_net_hibernate.jar ./plugins/Hibernate/config.yml
curl --create-dirs -sL -o ./plugins/alaister_net_hibernate.jar https://api.spiget.org/v2/resources/4441/download
curl --create-dirs -sL -o ./plugins/Hibernate/config.yml https://github.com/alaister-net/server-startup-scripts/raw/master/minecraft_java/config.yml
java -Xms128M -Xmx${MEMORY}M -Dterminal.jline=false -Dterminal.ansi=true -jar ${JARFILE}
