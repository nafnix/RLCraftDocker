## 使用 Docker 创建 RLCraft 服务器

默认使用：

- Java8 版本：华为毕昇的 JDK。你可以克隆该仓库后，修改其中的 `Dockerfile` 及 `init.sh` 文件里的相关内容使用你想使用的 Java8 版本。
- Forge 版本：forge-1.12.2-14.23.5.2860，同上，可以自行修改。
- RLCraft 版本：RLCraft+Server+Pack+1.12.2+-+Release+v2.9.1c，同上，可以自行修改。

你必须安装 docker 才能使用。对于 Debian/Ubuntu 系统，你可以使用下面这条命令进行安装：

```bash
apt install docker -y
```

对于其他的 Linux 系统，可以使用 docker 官方提供的一键脚本：

```bash
curl https://get.docker.com > /tmp/install.sh
chmod +x /tmp/install.sh
bash /tmp/install.sh
```

### 参考

- [GitHub - double-em/RLCraft-Server: Docker image for the Forge modded server with RLCraft installed](https://github.com/double-em/RLCraft-Server)

### 参数

使用时必须指定 `EULA` 环境变量值为 `true` 表明你同意 [Eula | Minecraft](https://www.minecraft.net/en-us/eula) 上面的用户许可协议

一个启动的例子：

```
docker run -p 25565:25565 -e EULA=true test/rlcraft-server
```

可指定参数如下表所示：

| 变量名 | 值              | 作用                       |
| ------ | --------------- | -------------------------- |
| Xms    | 以 G 为单位的值 | 设置最小运行占用内存       |
| Xmx    | 以 G 为单位的值 | 设置最大运行占用内存       |
| EULA   | 布尔值          | 确认你是否同意用户许可协议 |

一个使用示例：

```bash
docker run -dit \
		   -p 25565:25565 \
		   -e EULA=true \
		   -e Xms=4G \
		   -e Xmx=6G \
		   --name rlc \
		   test/rlcraft-server
```

### 直接使用

```bash
# 拉取
docker pull nafnix/rlcraft-server
```

运行示例，指定最小占用内存 `4G`，最大占用内存 `6G`，将容器内的 `25565` 端口映射到主机的 `23333` 端口，名为 `rlc` 的容器：

```bash
docker run -dit \
		   -p 23333:25565 \
		   -e EULA=true \
		   -e Xms=4G \
		   -e Xmx=6G \
		   --name rlc \
		   nafnix/rlcraft-server
```

可以将文件指定挂载到本地指定路径下，方便后期的修改或备份：

```bash
mkdir /home/rlcraft-server

docker run -dit \
		   -p 25565:25565 \
		   -e EULA=true \
		   -e Xms=4G \
		   -e Xmx=6G \
		   -v /home/rlcraft-server:/home/mcserver/RLCraft-Server \
		   --name rlc \
		   nafnix/rlcraft-server
```

### 本地构建并运行

#### 构建前的准备

需要安装 git。对于 Debian/Ubuntu 系统，可以使用下面这条命令进行安装：

```bash
apt install git -y
```

然后克隆仓库：

```bash
git clone https://github.com/nafnix/RLCraftDocker.git

cd RLCraftDocker
```

#### 构建

构建命令：

```bash
docker build -t test/rlcraft-server .
```

#### 运行示例

```bash
docker run -e EULA=true test/rlcraft-server
```
