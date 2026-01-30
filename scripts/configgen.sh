#! /usr/bin/env bash

configGen(){
if [ $REGEN_CONFIG = "true" ]; then
	echo "Generating config JSON...."
	jq -n \
  	  --arg name "$SERVER_NAME" \
  	  --arg motd "$MOTD" \
  	  --arg pass "$PASSWORD" \
  	  --argjson max "$MAX_PLAYERS" \
  	  --argjson radius "$MAX_RADIUS" \
  	  --arg world "$WORLD_NAME" \
  	  --arg mode "$GAME_MODE" \
  '{
    	"Version": 3,
    	"ServerName": $name,
    	"MOTD": $motd,
    	"Password": $pass,
    	"MaxPlayers": $max,
    	"MaxViewRadius": $radius,
    	"LocalCompressionEnabled": false,
    	"Defaults": {
      	"World": $world,
      	"GameMode": $mode
    	},
    	"ConnectionTimeouts": {
      	"JoinTimeouts": {}
    	},
    	"RateLimit": {},
    	 "Modules": {
      	  "PathPlugin": {
           "Modules": {}
      	}
    	},
    	"LogLevels": {},
    	"Mods": {},
    	"DisplayTmpTagsInStrings": false,
    	"PlayerStorage": {
      	  "Type": "Hytale"
    	},
    	  "AuthCredentialStore": {
      	  "Type": "Encrypted",
      	  "Path": "auth.enc"
    	 }
     }' > config.json
	echo -e "config generated.\n"

else
  echo -e "Skipping config JSON generation.\n"
fi
}