#! /usr/bin/env bash

updateCheck(){
    local currentver
    local jarver
    if [ -f $JARFILE ]; then
        
        currentver=$(echo "v$(./ht-downloader -print-version)")
        jarver=$(java -jar $JARFILE --version | cut -d ' ' -f 2)

        if (( $currentver > $jarver )); then
            echo -e "New Version Avilable updating Server JAR....\n"
            ./ht-downloader -download-path game.zip
            
        fi

    else

    fi


}