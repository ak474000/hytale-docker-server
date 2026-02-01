#! /usr/bin/env bash

source /scripts/gamepatchline.sh
source /scripts/configgen.sh

MEMORY="-Xms${MEMORY:-4G} -Xmx${MEMORY:-4G}"
SERVER_NAME=${SERVER_NAME:-"Hytale Server"}
MOTD=${MOTD:-""}
PASSWORD=${PASSWORD:-""}
MAX_PLAYERS=${MAX_PLAYERS:-100}
MAX_RADIUS=${MAX_RADIUS:-32}
WORLD_NAME=${WORLD_NAME:-"default"}
GAME_MODE=${GAME_MODE:-"Adventure"}
JARFILE="HytaleServer.jar"
ASSETS_ZIP="Assets.zip"
JAVA_ARGS=${JAVA_ARGS:-""}
REGEN_CONFIG=${REGEN_CONFIG:-"true"}
KEEP_DOWNLOADS=${KEEP_DOWNLOADS:-"false"}
PRE_RELEASE=${PRE_RELEASE:-"false"}

unZipGame(){
    unzip -o game.zip Server/HytaleServer.aot Server/HytaleServer.jar Assets.zip -d .
    mv ./Server/HytaleServer.jar .
    mv ./Server/HytaleServer.aot .
}

# from /scripts/configgen.sh
# uses jq to create server config structure and substituent above relevant ENV variables
configGen

echo "Validating Downloader..."
if [ ! -f "ht-downloader" ]; then
    echo "Unable to locate Hytale Downloader..."
    
    if [ ! -f "download.zip" ]; then
        echo -e "Downloading Hytale downloader...\n"
        curl -L -o download.zip https://downloader.hytale.com/hytale-downloader.zip
    else
        echo "Located local copy of download.zip Extracting...."
    fi
    
    unzip -o download.zip hytale-downloader-linux-amd64
    mv hytale-downloader-linux-amd64 ht-downloader
    chmod +x ht-downloader
    echo -e "Done.\n"
else
    echo -e "Downloader Validated.\n"
fi


echo "Validating Server JAR and dependencies..."
if [ ! -f $JARFILE ]  || [ ! -f $ASSETS_ZIP ] || [ ! -f "HytaleServer.aot" ]; then
    echo "Games files missing..."
    
    if [ ! -f "game.zip" ]; then
         patchLineCheck
        
    else
        echo "Located local copy of game.zip" 
        echo "Uncompressing....this can take a bit..."
        unZipGame
        patchLineCheck
    fi

else
    echo -e "Game files Validated.\n"
    patchLineCheck
fi

if [ $KEEP_DOWNLOADS = "false" ]; then 
    echo "Keep Downloaded files is false..."
    echo "cleaning up Zips and files if needed..."

    if [ -f "game.zip" ]; then
        echo "deleting game zip..."
        rm -dR game.zip
    fi  

    if [ -f "download.zip" ]; then
        echo "deleting downloads zip..."
        rm -dR download.zip
    fi
    echo -e "Done.\n"
else
    echo "Keeping Zip Files."
fi

if [ -d "Server" ]; then
    echo -e "deleting Server Directory... \n"
    rm -dR Server
fi

if [ -n "$JAVA_ARGS" ]; then
    echo -e "Server will run with the following arguments:\n $JAVA_ARGS\n"
else
    echo -e "No Java Arguments were Provided Starting Server...\n"
fi

exec java $MEMORY $JAVA_ARGS -jar $JARFILE --assets $ASSETS_ZIP --bind 0.0.0.0:5520
