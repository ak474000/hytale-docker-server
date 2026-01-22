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

you should now be able to initialize the container through compose

```docker compose up -d```

You can also build directly from a compose modifying it as such...

```
services:
  hytale:
    build:
      context: .
      dockerfile: Dockerfile
...
```

Context of '.' only works if the Dockerfile and its dependencies are within the same directory as the docker-compose.yaml. For those that like to use the bind mount of ./ within your compose and you are not planning on keeping the compose within the repo clone directory.


If you move the compose elsewhere, you will need to change context to a path on the host that the Dockerfile and its dependencies reside in.

```
services:
  hytale:
    build:
      context: /Path/On/Host/To/Dockerfile
      dockerfile: Dockerfile
...
```
You can also keep everything within the clone repo directory and if you wish for the server files to appear somewhere else and not with the repo files, change the volume bind mount in the compose where ever you like the Hytale server files to show up in.

```
...
    volumes:
      - Path/On/Host:/data
...
```



# Environment variables 
## DO NOTE: some java args will require the inclusion of the following argument to run  -XX:+UnlockExperimentalVMOptions

many of the environment variables have built in defaults as listed below. Port assignments are done through the port mapping within the compose if you need the server to run on a different port, change the mapping as follows

```
    ports:
      - "Host Port to Change:5520/udp"
```
You shouldn't need to modify the port the container runs on.

For the Java args, it might get messey adding them directly to the compose

```
    environment:
      - MEMORY=8G
      -JAVA_ARGS=-XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+DisableExplicitGC -XX:+AlwaysPreTouch...
```

you can make a .env file within the directory the compose is in and add the whatever name you like to the value will use ARGS as an example.

```
ARGS=-XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+DisableExplicitGC -XX:+AlwaysPreTouch...
```

Then within the compose you can add the ARGS .env key pair as so which will help keep the compose more compact.

```
    environment:
      - MEMORY=8G
      -JAVA_ARGS=${ARGS}
```


| **ENV**        | **Default Value** | **Description**                                                                                               | 
|----------------|-------------------|---------------------------------------------------------------------------------------------------------------|
| MEMORY         | 4G                | sets the Java memory heap Min and Max                                                                          | 
| SERVER_NAME    | Hytale Server     | Sets the config JSON Server Name                                                                              | 
| MOTD           | ""                | Sets Message Of The Day within Config JSON                                                                    | 
| PASSWORD       | ""                | Sets login password for server                                                                                |  
| MAX_PLAYERS    | 100               | Sets max players within confg JSON                                                                            | 
| MAX_RADIUS     | 32                | Sets server render range within config JSON                                                                   |  
| WORLD_NAME     | default           | Sets default world folder name within config JSON                                                             |  
| GAME_MODE      | Adventure         | Sets server game mode                                                                                         |  
| AUTO_UPDATE    | true              | Runs update check for new server version and installs it on container start                                   |    
| JAVA_ARGS      | ""                | Input a customer set of Java Arguments that the server will start with. See [community documentation](https://hytale-docs.com/docs/servers/setup/configuration#java-25-jvm-configuration) on recommended Arguments                                       |  
| REGEN_CONFIG   | true              | regenerates the config JSON inputting set ENV variables                                                       |    
| KEEP_DOWNLOADS | false             | keeps the zips from downloading Hytale Downloader and the game files. This helps to prevent extra downloads.  | 