FROM debian

RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup

ADD sources.list /etc/apt/

RUN apt update && \
    apt upgrade -y && \
    apt autoremove -y && \
    apt install -y apt-transport-https ca-certificates nano vim wget unzip git htop python3 pip screen && \
    mkdir ~/mcserver && \
    cd ~/mcserver && \
    wget https://mirrors.huaweicloud.com/kunpeng/archive/compiler/bisheng_jdk/bisheng-jre-8u342-linux-x64.tar.gz && \
    tar zxvf bisheng-jre-8u342-linux-x64.tar.gz && \
    mkdir backup && \
    mv bisheng-jre-8u342-linux-x64.tar.gz backup/ && \
    export PATH=$PATH:/root/mcserver/bisheng-jre1.8.0_342/bin/ && \
    mkdir RLCraft-Server && \
    cd RLCraft-Server && \
    wget https://mediafiles.forgecdn.net/files/3655/676/RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
    unzip RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip && \
    mv RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c.zip ../backup && \
    wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar && \
    java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer && \
    mv forge-1.12.2-14.23.5.2860-installer.* ../backup/ && \
    java -jar forge-1.12.2-14.23.5.2860.jar nogui && \
    sed -i 's/eula=false/eula=true/g' eula.txt && \
    echo "java -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms4G -jar forge-1.12.2-14.23.5.2860.jar" >> run.sh && \
    chmod +x run.sh && \
    pip install nbt -i https://mirror.sjtu.edu.cn/pypi/web/simple && \
    wget https://cdn.jsdelivr.net/gh/DMBuce/mcexplore/mcexplore.py && \
    chmod +x mcexplore.py && \
    python mcexplore.py -v -c "java -server -jar forge-1.12.2-14.23.5.2860.jar nogui" 30 && \
    bash run.sh