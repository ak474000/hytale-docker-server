#! /usr/bin/env bash

patchLineCheck(){
    local checkversion=""
    if [ -f $JARFILE ]; then    
        
        checkversion=$(java -jar $JARFILE --version | cut -d ' ' -f 3)
        checkversion=$(echo ${checkversion//[().,]})
        echo -e "Downloaded Server PatchLine: $checkversion\n"
        
        case $PRE_RELEASE in
            true)
                if [ $checkversion = "release"  ]; then  
                    echo "Pre release selected and swapping out versions..."
                    ./ht-downloader -patchline pre-release -download-path game.zip
                    echo "Uncompressing....this can take a bit..."
                    unzip -o game.zip Server/HytaleServer.aot Server/HytaleServer.jar Assets.zip -d .
                    mv ./Server/HytaleServer.jar .
                    mv ./Server/HytaleServer.aot .
                else
                    echo "Game matches Patchline Pre-Release."  
                fi
                ;;
            false) 

                if [ $checkversion != "release" ]; then
                    echo "Release selected and swapping out versions...."
                    ./ht-downloader -download-path game.zip
                    echo "Uncompressing....this can take a bit..."
                    unzip -o game.zip Server/HytaleServer.aot Server/HytaleServer.jar Assets.zip -d .
                    mv ./Server/HytaleServer.jar .
                    mv ./Server/HytaleServer.aot .
                else 
                    echo "Game matches Patchline Release."
                fi
                ;;
            *) 
                echo "invalid value for PRE_RELEASE needs to be either 'true' or 'false'"
                exit 1
                ;;    
        esac
    else
        if [ $PRE_RELEASE = "true" ]; then
            echo "JAR missing. Pre Release version selected, downloading."
            ./ht-downloader -patchline pre-release -download-path game.zip
            echo "Uncompressing....this can take a bit..."
            unzip -o game.zip Server/HytaleServer.aot Server/HytaleServer.jar Assets.zip -d .
            mv ./Server/HytaleServer.jar .
            mv ./Server/HytaleServer.aot .
        else
            echo "JAR missing. Grabbing release version."
            ./ht-downloader -download-path game.zip
            echo "Uncompressing....this can take a bit..."
            unzip -o game.zip Server/HytaleServer.aot Server/HytaleServer.jar Assets.zip -d .
            mv ./Server/HytaleServer.jar .
            mv ./Server/HytaleServer.aot .
        fi
    fi
}