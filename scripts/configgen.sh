#! /usr/bin/env bash

configGen(){
if [ $REGEN_CONFIG = "true" ]; then
	echo "Generating Server/World config JSON...."
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
  	"PlayerStorage": {
    	"Type": "Hytale"
  	},
  	"AuthCredentialStore": {
    	"Type": "Encrypted",
    	"Path": "auth.enc"
  	}
   }' > config.json
	echo -e "Server config generated.\n"

	if [ ! -d universe/worlds/$WORLD_NAME ]; then
		mkdir -p ./universe/worlds/$WORLD_NAME
	fi

	jq -n \
  	  --arg pvp "$PVP" \
	  --arg falldam "$FALL_DAMAGE" \
  	  --arg world "$WORLD_NAME" \
	'{
  	"WorldGen": {
    	"Type": "Hytale",
    	"Name": $world
  	},
  	"IsPvpEnabled": $pvp,
  	"IsFallDamageEnabled": $falldam,
	}' > ./universe/worlds/$WORLD_NAME/config.json
else
  echo -e "Skipping config JSON generation.\n"
fi
}