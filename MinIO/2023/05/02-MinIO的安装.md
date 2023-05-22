# MinIO的安装

`MinIO`官方支持多种安装方式、多个操作系统。那我这里只记录自己平时用到比较多的安装方式，下面主要针对`Windows`、`Linux`和`MacOS`三种情况的部署方法。

## Windows下运行

首先我们去`MinIO`找到Windows下的安装包，下载页为` https://dl.minio.io/server/minio/release/windows-amd64`，最新版的下载地址为` https://dl.minio.io/server/minio/release/windows-amd64/minio.exe`。如果我们需要下载历史的版本，下载页为`https://dl.minio.io/server/minio/release/windows-amd64/archive/`。

比如现在下载最后一个免费版本的，其下载地址为`https://dl.minio.io/server/minio/release/windows-amd64/archive/minio.RELEASE.2021-04-22T15-44-28Z`；下载之后需要重命名下，改为`minio.exe`。然后在当前目录打开控制台，输入命令`minio.exe server D:/mini-data`就可以启动了。最后在浏览器输入`http://localhost:9000/`就可以体验了。

### 自定义账号和密码

刚刚运行由于没有账号和密码，`MinIO`会使用默认账号`minioadmin`和密码`minioadmin`。如果需要自定义账号和密码的话，这里给出两种方案

* 启动时指定

  我们可以将`MinIO`的启动封装成一个CMD脚本，启动时只要双击脚本文件，我们新建一个`minio.cmd`文件，其内容如下：
  
  ```cmd
  @echo off
  set MINIO_ROOT_USER=admin
  set MINIO_ROOT_PASSWORD=123456789
  .\minio.exe server .\minio-data
  ```

* 先启动后改配置文件

  这种方式先用命令`.minio.exe server .\minio-data`，然后找到配置文件`.\minio-data\.minio.sys\config\config.json`，用VSCode打开这个配置文件，找到账号和密码的配置项。

  搜索`key`为`access_key`，这个是用户名的意思，其值`value`改为自己的用户名，然后搜索`key`为`secret_key`，这个密码的意思，其值`value`改为自己的密码。

  保存配置文件之后，关闭`CMD`，然后重新在命令行窗口输入`.minio.exe server .\minio-data`，这个时候在浏览器就需要输入新的账号和密码了。

需要特别注意的是，如果已经采用了第一种方式，就不能再用第二种方式了修改密码了，因为MinIO会对配置文件加密处理。

应该还有第三种方式，就是通过客户端`mc`修改，这个后面再看了，这里就不再记录了。

## Linux下运行

这里以`Linux AMD64`为例，最新版的下载地址为`https://dl.minio.io/server/minio/release/linux-amd64/minio`。
在Linux下我们尝试安装最新版（`minio.RELEASE.2023-05-18T00-05-36Z`）。

```bash
curl https://dl.minio.io/server/minio/release/linux-amd64/minio -O /opt/minio
chmod +x /opt/minio
/opt/minio server /opt/minio-data
```

如果`Linux`防火墙已开启，则需要执行命令`sudo firewalld-cmd --add-port=9000/tcp --zone=public --permanent && sudo firewalld-cmd --reload`。

最后在浏览器输入`http://localhost:9000/`就可以体验了。

### 自定义账号和密码

跟`Windows`差不多，编写一个启动脚本，通过脚本启动。我们新建一个`minio.sh`文件，其内容如下：

```bash
#!/bin/bash
export MINIO_ROOT_USER=admin
export MINIO_ROOT_PASSWORD=123456789
nohup /opt/minio server /opt/minio-data >> minio.log 2>&1 &
```

## MacOS下运行

首先去`MinIO`官网的Mac下载页`https://dl.minio.io/server/minio/release/darwin-amd64/`，选择相应的版本下载，这里下载最新的`https://dl.minio.io/server/minio/release/darwin-amd64/minio`，然后打开命令行工具，在命令行执行如下命令：

```bash
cd ~/Downloads
chmod +x ./minio
./minio server data
```

以上假设`minio`下载保存到`~/Downloads`。
