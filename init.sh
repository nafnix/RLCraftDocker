#!/bin/bash

DEFAULT_Xms=4G
DEFAULT_Xmx=4G
JAVA=/home/mcserver/bisheng-jre1.8.0_342/bin/java
readonly DEFAULT_Xms
readonly DEFAULT_Xmx

if [ -z "${EULA}" ]; then
    echo "请输入EULA环境变量的值"
    echo "设置 EULA=true 即表明你同意 https://www.minecraft.net/en-us/eula 上面的用户许可协议"
else
    if [ "${EULA}" = "true" ]; then

        cd /home/mcserver/RLCraft-Server/

        sed -i 's/eula=false/eula=true/g' eula.txt

        if [ -z "${Xms}"]; then
            echo "没有设置最小内存，将使用默认内存设置：[${DEFAULT_Xms}]"
            Xms=$DEFAULT_Xms
        else
            echo "最小内存设置为: ${Xms}"
        fi

        if [ -z "${Xmx}" ]; then
            echo "没有设置最大内存，将使用默认内存设置：[${DEFAULT_Xmx}]"
            Xmx=$DEFAULT_Xmx
        else
            echo "最大内存设置为：${Xmx}"
        fi

        START="${JAVA} -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=4 -XX:+AggressiveOpts -Xms${Xms} -Xmx${Xmx} -jar forge-1.12.2-14.23.5.2860.jar nogui"
        echo "启动命令: ${START}"
        $START
    else
        echo "你需要设置 EULA 为 true 表示同意 https://www.minecraft.net/en-us/eula 上面的用户许可协议才可以继续运行"
    fi
fi
