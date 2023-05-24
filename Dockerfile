FROM amazoncorretto:8-alpine-jre

ARG directory=/rlcraft

WORKDIR ${directory}

RUN set -x \
    && apk add curl --no-cache \
    && curl -O https://mediafilez.forgecdn.net/files/4487/650/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && unzip RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && rm -f RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && curl -O https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar \
    && java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer \
    && rm -f forge-1.12.2-14.23.5.2860-installer.* \
    && apk del curl

COPY ./launch.sh ./server.properties ./
RUN chmod +x launch.sh

ENV XMS=2G XMX=4G EULA= START_SIZE=

EXPOSE 25565/TCP

VOLUME "${directory}/world"

CMD ["./launch.sh"]
