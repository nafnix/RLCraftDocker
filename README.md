# 使用 Docker 创建 RLCraft 服务器

## 构建

```bash
docker build -t rlcraft-server .
```

## 启动示例

### 使用默认配置启动

使用 `-v` 指定世界存档路径。

```bash
docker run -it \
           -p 25565:25565 \
           -v my-rlcraft-world:/rlcarft/World \
           --name my-rlcraft \
           rlcraft-server
```

### 指定内存大小

| 变量名 | 值              | 作用                       | 示例 |
| ------ | --------------- | -------------------------- | ---- |
| Xms    | 以 G 为单位的值 | 设置最小运行占用内存       | `3G` |
| Xmx    | 以 G 为单位的值 | 设置最大运行占用内存       | `5G` |

一个使用示例：

```bash
docker run -it \
           -p 25565:25565 \
           -e Xms=3G \
           -e Xmx=5G \
           -v my-rlcraft-world:/rlcarft/World \
           --name my-rlcraft \
           rlcraft-server
```

### 在后台运行

```bash
docker run -d \
           -p 25565:25565 \
           -e Xms=3G \
           -e Xmx=5G \
           -v my-rlcraft-world:/rlcarft/World \
           --name my-rlcraft \
           rlcraft-server
```

## 使用 Docker Hub 上已构建好的容器示例

可能因为本地网络不佳或是其他什么原因，总是在某一部构建失败，为此可以使用我已经构建好的容器。

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
           -e Xms=3G \
           -e Xmx=5G \
           -v my-rlcraft-world:/rlcarft/World \
           --name my-rlcraft \
           nafnix/rlcraft-server:v2.9.2d
```
