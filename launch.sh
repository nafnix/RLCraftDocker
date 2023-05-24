#!/usr/bin/env sh

run() {
    java \
        -server \
        -XX:-UseVMInterruptibleIO \
        -XX:NewRatio=3 \
        -XX:+UseConcMarkSweepGC \
        -XX:+UseParNewGC \
        -XX:+CMSIncrementalPacing \
        -XX:ParallelGCThreads=4 \
        -XX:+AggressiveOpts \
        -XX:+UseFastAccessorMethods \
        -XX:+UseBiasedLocking \
        -XX:+CMSParallelRemarkEnabled \
        -XX:MaxGCPauseMillis=50 \
        -XX:+UseAdaptiveGCBoundary \
        -XX:-UseGCOverheadLimit \
        -XX:SurvivorRatio=8 \
        -XX:TargetSurvivorRatio=90 \
        -XX:MaxTenuringThreshold=15 \
        -XX:+DisableExplicitGC \
        -Xnoclassgc \
        -oss4M \
        -ss4M \
        -XX:CMSInitiatingOccupancyFraction=60 \
        -XX:SoftRefLRUPolicyMSPerMB=2048 \
        -Xms${XMS} \
        -Xmx${XMX} \
        -jar forge-1.12.2-14.23.5.2860.jar \
        nogui
}

building_map() {
    echo "下载初始化地图所需依赖"
    apk add python3 py3-pip curl --no-cache
    curl -O https://cdn.jsdelivr.net/gh/DMBuce/mcexplore/mcexplore.py
    chmod +x mcexplore.py
    pip install nbt -i https://mirrors.cernet.edu.cn/pypi/web/simple --no-cache-dir --upgrade

    echo "开始初始化地图"
    python mcexplore.py \
        -v \
        -c "java -server -Xmx${XMX} -jar forge-1.12.2-14.23.5.2860.jar nogui" \
        ${START_SIZE}
    echo "地图初始化完毕"
    echo "移除初始化地图的相关依赖"
    apk del python3 py3-pip curl
}

if [ "${EULA}" = "true" ]; then
    echo "eula=${EULA}" >eula.txt

    if [[ -n "${START_SIZE}" ]]; then
        if [[ ${START_SIZE} =~ ^[0-9]+$ ]]; then
            if test ${START_SIZE} -ge 26; then
                building_map
            else
                echo "START_SIZE 值最小值是 26，而当前是 ${START_SIZE}"
                exit 1
            fi
        else
            echo "START_SIZE 必须是正整数"
            exit 2
        fi
    fi

    run

else
    echo "必须指定 -e EULA=true 表示同意 https://www.minecraft.net/en-us/eula 上面的最终用户许可协议才可以继续运行"
fi
