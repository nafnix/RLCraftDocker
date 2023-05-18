FROM curlimages/curl as get-file-stage

WORKDIR /tmp

RUN curl -O https://mediafilez.forgecdn.net/files/4487/650/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip
RUN curl -O https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar


FROM amazoncorretto:8-alpine-jre

ENV Xms=3G Xmx=5G

EXPOSE 25565

WORKDIR /rlcarft

COPY --from=get-file-stage /tmp/* .

# 解压并移除压缩包
RUN unzip RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip \
    && rm -f RLCraft+Server+Pack+1.12.2+-+Release+v2.9.2d.zip

# 初始化服务器
RUN java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer \
    && rm -f forge-1.12.2-14.23.5.2860-installer.* \
    && java -jar forge-1.12.2-14.23.5.2860.jar nogui \
    && sed -i 's/eula=false/eula=true/g' eula.txt

# 复制服务器启动文件
COPY ./server.properties .

# 备份世界存档
VOLUME /rlcarft/World

# 启动命令
CMD java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms${Xms} -Xmx${Xmx} -jar forge-1.12.2-14.23.5.2860.jar nogui