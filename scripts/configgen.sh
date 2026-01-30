#!/bin/bash

configGen(){
if [ $REGEN_CONFIG = "true" ]; then
	echo "Generating config JSON...."

	cat config.json | \
	jq --arg sname "$SERVER_NAME" \
  	  --arg motd "$MOTD" \
  	  --arg passw "$PASSWORD" \
  	  --argjson maxp "$MAX_PLAYERS" \
  	  --argjson radius "$MAX_RADIUS" \
  	  --arg worldn "$WORLD_NAME" \
  	  --arg gmode "$GAME_MODE"  \
	'.ServerName |= $sname | .MOTD |= $motd | .Password |= $passw | .MaxPlayers |= $maxp | .MaxViewRadius |= $radius | .Defaults.World |= $worldn | .Defaults.GameMode |= $gmode' > config.tmp && mv config.tmp config.json
	
	local testauth=$(jq config.json '.AuthCredentialStore.Type')

	if [ $testauth  != "Encrypted" ]; then
		cat config.json | jq '. += [{"AuthCredentialStore"{"Type": "Encrypted", "Path": "auth.enc"}}]' > config.tmp && mv config.tmp config.json
	fi

	echo -e "config generated.\n"
else
  echo -e "Skipping config JSON generation.\n"
fi
}