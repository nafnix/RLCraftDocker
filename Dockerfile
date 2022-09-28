FROM debian

RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup

COPY sources.list /etc/apt/

RUN apt update && \
    apt upgrade -y && \
    apt autoremove -y && \
    apt install -y wget unzip && \
    mkdir /home/mcserver/ && \
    cd /home/mcserver/ && \
    wget https://mirrors.huaweicloud.com/kunpeng/archive/compiler/bisheng_jdk/bisheng-jre-8u342-linux-x64.tar.gz && \
    tar zxvf bisheng-jre-8u342-linux-x64.tar.gz && \
    rm -f bisheng-jre-8u342-linux-x64.tar.gz && \
    export PATH=$PATH:/home/mcserver/bisheng-jre1.8.0_342/bin/ && \
    mkdir RLCraft-Server && \
    cd RLCraft-Server && \
    wget https://mediafiles.forgecdn.net/files/3655/676/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
    unzip RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
    rm -f RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
    wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar && \
    java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer && \
    rm -f forge-1.12.2-14.23.5.2860-installer.* && \
    java -jar forge-1.12.2-14.23.5.2860.jar nogui && \
    # sed -i 's/eula=false/eula=true/g' eula.txt && \
    # echo "java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms4G -jar forge-1.12.2-14.23.5.2860.jar" >> run.sh && \
    # chmod +x run.sh && \
    # pip install nbt -i https://mirror.sjtu.edu.cn/pypi/web/simple && \
    # wget https://cdn.jsdelivr.net/gh/DMBuce/mcexplore/mcexplore.py && \
    # chmod +x mcexplore.py && \
    # python3 mcexplore.py -v -c "java -server -jar forge-1.12.2-14.23.5.2860.jar nogui" 30 && \
    rm -f server.properties && \
    echo "Build RLCraft Server Docker Over"

COPY server.properties /home/mcserver/RLCraft-Server/

COPY init.sh /home/mcserver/

ENTRYPOINT ["/home/mcserver/init.sh"]