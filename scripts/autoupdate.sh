#!/bin/bash

autoUpdate() {
    if [ -f $JARFILE ] && [ -f "ht-downloader" ]; then
        echo "Auto Updates Enabled, Checking...."
        current_version=$(./ht-downloader -print-version)
        downloaded_version=$(java -jar HytaleServer.jar --version | cut -d ' ' -f 2 | cut -d v -f 2)

        echo "current version: $current_version"
        echo "downloaded version: $downloaded_version"

        if [ $current_version != $downloaded_version ]; then
            echo "Server out of date"
            echo "grabbing game files"
            ./ht-downloader -download-path game.zip
            echo "Uncompressing...."
            unzip -o game.zip
            mv ./Server/HytaleServer.jar .
            mv ./Server/HytaleServer.aot .
            echo -e "update complete.\n"
        else
            echo -e "Server is up to date.\n"
        fi
    else
        echo "Error finding Downloader and or Hytale server Jar Exiting...."
        exit 1
    fi
}
