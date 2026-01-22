FROM eclipse-temurin:25-jre-jammy

RUN apt-get update && apt-get install -y curl jq unzip && rm -rf /var/lib/apt/lists/*

RUN mkdir /scripts

WORKDIR /data

COPY scripts /scripts

RUN chmod +x /scripts/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

ENTRYPOINT [ "/entrypoint.sh" ]