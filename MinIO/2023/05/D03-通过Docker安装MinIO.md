# 通过Docker安装MinIO

[toc]

在[MinIO的安装](./02-MinIO%E7%9A%84%E5%AE%89%E8%A3%85.md)都是宿主机直接安装的，本篇笔记主要记录的是Docker、Docker-Compose的安装。

## 前提条件

确保自己的电脑已经安装了Docker，目前我的公众号笔记中还没上传Docker相关，这里简单提一下，Windows下安装非常简单的，跟安装其它软件没啥区别。

## Docker运行

`MinIO`需要一个持久卷来存储配置和应用数据。不过, 如果只是为了测试一下, 可以通过简单地传递一个目录启动`MinIO`。这个目录会在容器启动时在容器的文件系统中创建，缺点就是容器销毁时旧数据也就丢失了。在下面的示例中将数据和配置保存在容器中的`/data`：

```bash
docker run -p 9000:9000 minio/minio server /data
```

如果需要将数据保存到宿主机上，则需要做目录映射。下面的命令分别给出了Window、Linux和MacOS的不同写法：

* Windows

  ···cmd
  docker run -d --name minio-try -v D:\data:/data minio/minio server /data
  ```

* Linux和MacOS

  ```bash
  docker run -d --name minio-try -v ~/data:/data minio/minio server /data
  ```

## 自定义Access和Secret

要覆盖`MinIO`的自动生成的密钥，您可以将`Access`和`Secret`密钥设为环境变量。 `MinIO`允许常规字符串作为`Access`和`Secret`密钥。

* Linux 和 macOS

  ```bash
  docker run -p 9000:9000 --name minio1 \
  -e "MINIO_ACCESS_KEY=admin" \
  -e "MINIO_SECRET_KEY=bPxRfiCYEXAMPLEKEY" \
  -v /mnt/data:/data \
  minio/minio server /data
  ```

* Windows

  ```cmd
  docker run -p 9000:9000 --name minio1 \
  -e "MINIO_ACCESS_KEY=admin" \
  -e "MINIO_SECRET_KEY=bPxRfiCYEXAMPLEKEY" \
  -v D:\data:/data \
  minio/minio server /data
  ```

## Docker Compose运行

必须要先安装`docker-compose`，目前我的公众号笔记中还没上传`docker-compose`相关，不过如果是Windows的话，自动安装了`docker-compose`。

可以Docker Compose来启动`MinIO`，首先我们需要准备一个`docker-compose.yml`文件，下面的示例给出简单启动一个`MinIO`：

```yaml
version: "3"
services:
  mored-minio:
    image: minio/minio
    container_name: mt-minio
    ports:
      - "9000:9000"
    environment:
      MINIO_ACCESS_KEY: moredadmin
      #管理后台用户名
      MINIO_SECRET_KEY: moredadmin..123
      #管理后台密码，最小8个字符
    volumes:
      #映射当前目录下的data目录至容器内/data目录
      - ./data:/data
      - ./config:/root/.minio/
      #映射配置目录
    command: server /data
    privileged: true
    restart: always
    networks:
      - mored_dev_network
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: "8GB"

networks:
  mored_dev_network:
    external: true
```

然后执行下面的命令就可以启动：

```sh
dockerc-ompose up -d
```

https://www.wenjiangs.com/docs/minio