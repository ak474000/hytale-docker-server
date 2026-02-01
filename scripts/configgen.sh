#! /usr/bin/env bash

configGen(){
if [ $REGEN_CONFIG = "true" ]; then
	echo "Generating Server config JSON...."
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
	
	# world config seeding
	if [ ! -d "universe" ]; then
		mkdir universe/worlds/${WORLD_NAME}
	fi
	jq -n \
  	  --argjson max "$" \
  	  --arg mode "$" \
	'{
  	"Version": 4,
  	"UUID": {
    	"$binary": "bUBOwTlMRXq1Dmllz5ERgg==",
    	"$type": "04"
 	 },
  	"Seed": ,
  	"WorldGen": {
    	"Type": "Hytale",
    	"Name": "Default"
  	},
  	"WorldMap": {
    	"Type": "WorldGen"
  	},
  	"ChunkStorage": {
    	"Type": "Hytale"
  	},
  	"ChunkConfig": {},
  	"IsTicking": true,
  	"IsBlockTicking": true,
  	"IsPvpEnabled": false,
  	"IsFallDamageEnabled": true,
  	"IsGameTimePaused": false,
  	"GameTime": "0001-01-09T11:53:05.741520798Z",
  	"ClientEffects": {
    	"SunHeightPercent": 100.0,
    	"SunAngleDegrees": 0.0,
    	"BloomIntensity": 0.30000001192092896,
    	"BloomPower": 8.0,
    	"SunIntensity": 0.25,
    	"SunshaftIntensity": 0.30000001192092896,
    	"SunshaftScaleFactor": 4.0
  	},
  	"RequiredPlugins": {},
  	"IsSpawningNPC": true,
  	"IsSpawnMarkersEnabled": true,
  	"IsAllNPCFrozen": false,
  	"GameplayConfig": "Default",
  	"IsCompassUpdating": true,
  	"IsSavingPlayers": true,
  	"IsSavingChunks": true,
  	"SaveNewChunks": true,
  	"IsUnloadingChunks": true,
  	"IsObjectiveMarkersEnabled": true,
  	"DeleteOnUniverseStart": false,
  	"DeleteOnRemove": false,
  	"ResourceStorage": {
    	"Type": "Hytale"
  	},
  	"Plugin": {}
	}' > ./universe/worlds/${WORLD_NAME}/config.json

else
  echo -e "Skipping config JSON generation.\n"
fi
}