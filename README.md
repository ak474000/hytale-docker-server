# hytale-docker-server
Hytale Server containerized with Auto updating Support

this image supports auto updating server JAR on container restart and being able to set configuration through environment variables listed below.

# Build From Repo

Install Docker from https://docs.docker.com/engine/install/

clone repo 

```git clone https://github.com/ak474000/hytale-docker-server.git```

ensure your working directory is within the cloned folder

run

```docker build -t <add your own tag> .```

you should now be able to initalize the container through compose

```docker compose up -d```

# Enviornment variables 

| **ENV**        | **Default Value** | **Description**                                                                                               | 
|----------------|-------------------|---------------------------------------------------------------------------------------------------------------|
| MEMORY         | 4G                | sets the Java memory heap Min and Mx                                                                          | 
| SERVER_NAME    | Hytale Server     | Sets the config JSON Server Name                                                                              | 
| MOTD           | ""                | Sets Message Of The Day within Config JSON                                                                    | 
| PASSWORD       | ""                | Sets login password for server                                                                                |  
| MAX_PLAYERS    | 100               | Sets max players within confg JSON                                                                            | 
| MAX_RADIUS     | 32                | Sets server render range within config JSON                                                                   |  
| WORLD_NAME     | default           | Sets default world folder name within config JSON                                                             |  
| GAME_MODE      | Adventure         | Sets server game mode                                                                                         |  
| AUTO_UPDATE    | true              | Runs update check for new server version and installs it on container start                                   |    
| JAVA_ARGS      | ""                | Input a customer set of Java Arguments that the server will start with                                        |  
| REGEN_CONFIG   | true              | regenerates the config JSON inputting set ENV variables                                                       |    
| KEEP_DOWNLOADS | false             | keeps the zips from downloading Hytale Downloader and the game files. This helps to prevent extra downloads.  | 
