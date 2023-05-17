FROM openjdk:8u342-jre

ENV Xms=3G Xmx=5G

EXPOSE 25565

WORKDIR /rlcarft

RUN curl -O https://mediafilez.forgecdn.net/files/4487/650/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && unzip RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && rm -f RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip

RUN curl -O https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar \
    && java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer \
    && rm -f forge-1.12.2-14.23.5.2860-installer.* \
    && java -jar forge-1.12.2-14.23.5.2860.jar nogui \
    && sed -i 's/eula=false/eula=true/g' eula.txt

COPY ./server.properties .

VOLUME /rlcarft/World

CMD java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms${Xms} -Xmx${Xmx} -jar forge-1.12.2-14.23.5.2860.jar nogui