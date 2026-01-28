FROM eclipse-temurin:25-jre-jammy

RUN apt-get update && apt-get install -y curl jq unzip && apt-get clean && rm -rf /var/lib/apt/lists/* && mkdir /scripts

COPY . /

RUN chmod +x /entrypoint.sh /scripts/*

WORKDIR /data

ENTRYPOINT [ "/entrypoint.sh" ]