# 使用 Docker 创建 RLCraft 服务器

## 参考项目

- [double-em/RLCraft-Server](https://github.com/double-em/RLCraft-Server)
- [GitHub - DMBuce/mcexplore: Use a Minecraft server to generate a square of land](https://github.com/DMBuce/mcexplore#usage)
- [教程/架设服务器 - Minecraft Wiki，最详细的我的世界百科](https://minecraft.fandom.com/zh/wiki/%E6%95%99%E7%A8%8B/%E6%9E%B6%E8%AE%BE%E6%9C%8D%E5%8A%A1%E5%99%A8?variant=zh#%E4%BD%BF%E7%94%A8Java_8%E6%88%96%E4%B9%8B%E5%89%8D%E7%9A%84%E7%89%88%E6%9C%AC)

## 本地构建并运行

### 构建

```bash
docker build -t rlcraft-server .
```

### 运行示例

#### 使用默认配置启动

- `-v mc-rlcraft-world:/rlcraft/world`: 备份世界存档路径。当指定该值后，后续再使用此值将会使用相同的地图。如果不需要备份地图，可以不指定这个值。
- `-e EULA=true`: 表示同意 [MINECRAFT END USER LICENSE AGREEMENT](https://www.minecraft.net/en-us/eula)。

```bash
docker run -it \
           -p 25565:25565 \
           -e EULA=true \
           -v mc-rlcraft-world:/rlcraft/world \
           --name mc-rlcraft \
           rlcraft-server
```

#### 指定内存大小

| 变量名 | 值       | 作用                 | 默认值 |
| ------ | -------- | -------------------- | ------ |
| `XMS`  | 内存空间 | 设置最小运行占用内存 | `3G`   |
| `XMX`  | 内存空间 | 设置最大运行占用内存 | `5G`   |

一个使用示例：

```bash
docker run -it \
           -p 25565:25565 \
           -e XMS=3G \
           -e XMX=5G \
           -e EULA=true \
           -v mc-rlcraft-world:/rlcraft/world \
           --name mc-rlcraft \
           rlcraft-server
```

#### 指定初始地图大小

**建议：指定该命令时携带 `-v mc-rlcraft-world:/rlcraft/world` 参数。**

| 变量名       | 值                 | 作用                 |
| ------------ | ------------------ | -------------------- |
| `START_SIZE` | 最小是 `26` 的数字 | 启动服务器前构建地图 |

相关信息参考：[GitHub - DMBuce/mcexplore: Use a Minecraft server to generate a square of land](https://github.com/DMBuce/mcexplore#usage) 的第一个示例，此处只能指定一个值。

若设置过大的值可能导致超长时间的加载，建议在开始游玩的前几天设置此值。

```bash
docker run -it \
           -p 25565:25565 \
           -e EULA=true \
           -e START_SIZE=26 \
           -v mc-rlcraft-world:/rlcraft/world \
           --name mc-rlcraft \
           rlcraft-server
```

#### 在后台运行

```bash
docker run -d \
           -p 25565:25565 \
           -e XMS=3G \
           -e XMX=5G \
           -e EULA=true \
           -v mc-rlcraft-world:/rlcraft/world \
           --name mc-rlcraft \
           rlcraft-server
```

#### 删除容器

```bash
docker stop mc-rlcraft
docker rm mc-rlcraft
```

#### 删除镜像

```bash
docker rmi rlcraft-server
```

## 使用 Docker Hub 上已构建好的容器示例

可能因为本地网络不佳或是其他什么原因，总是卡在某一步构建失败，解决这个问题的方法之一是使用我已经构建好的容器。

### 拉取容器

```bash
docker pull nafnix/rlcraft-server:v2.9.2d
```

### 运行容器

类似运行本地构建好的容器，只是容器名称换成 `nafnix/rlcraft-server:v2.9.2d`。

下面是一个在后台启动的示例：

```bash
docker run -d \
           -p 25565:25565 \
           -e XMS=1G \
           -e XMX=2G \
           -e EULA=true \
           -v mc-rlcraft-world:/rlcraft/world \
           --name mc-rlcraft \
           nafnix/rlcraft-server:v2.9.2d
```

关于更加详细的启动命令描述可以参考 [运行示例](https://github.com/nafnix/RLCraftDocker/tree/master#运行示例) 章节的内容
