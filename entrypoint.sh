#!/bin/bash
sleep 2

cd /home/container

# Update Unturned Server
./steam/steamcmd.sh +@sSteamCmdForcePlatformBitness 32 +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update 304930 +quit
echo "Downloading RocketMod..."
curl -o Rocket.zip "https://ci.rocketmod.net/job/Rocket.Unturned%20Linux/lastSuccessfulBuild/artifact/Rocket.Unturned/bin/Release/Rocket.zip"
unzip -o -q Rocket.zip

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

env
sleep 5

# Run the Server
${MODIFIED_STARTUP}
echo "=== If there was an error above, it can be safely ignored. ==="
