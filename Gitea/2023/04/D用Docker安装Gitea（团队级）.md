# 用Docker安装Gitea（团队级）

[toc]

为了满足团队使用，可能数据库需要使用公司的数据库，比如MySQL，同时`Gitea`的数据目录至少映射出来。

## 准备工作

在使用`Docker Compose`安装`Gitea`，需要现在服务器上安装`Docker Compose`。`Docker Compose`是`Docker`官方提供的一个工具，用于管理和运行多个`Docker`容器的工具。安装`Docker Compose`的这个过程可以在终端运行一下抿了来完成：

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 创建git用户

目的用于SSH拉取代码时用的，行业通用的用户名都是`git`。下面的命令可以完成`git`用户的创建：

```sh
# Create git group
groupadd git
# Show git group id
getent group git | cut -d: -f3
# 也可以用这个命令，同样能查看组ID grep '^git:' /etc/group | cut -d: -f3
# Create git user
adduser git
# Make sure user has UID and GID 1000
usermod -u 1000 -g 1000 git
# Add git user to docker group
usermod -aG docker git
```

## 准备docker-compose文件

现在我们可以创建一个新的目录，用于存放`Docker Compose`配置文件和`Gitea`的数据。我们可以通过以下命令创建一个`gitea`的目录：

```sh
mkdir -p /data/gitea/data && chown -R git:git /data/gitea/data && cd /data/gitea 
```
`chown -R git:git /data/gitea/data`用于将目录`/data/gitea/data`所属用户和组为`git`。

接下来就是编写

```yaml
version: "3.9"
services:
  gitea:
    image: gitea/gitea:latest
    container_name: tm-gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - APP_NAME="TM Git"
      - RUN_MODE=prod
      - START_SSH_SERVER=true
      - RUN_USER=git
      - PROTOCOL=http
      - DOMAIN=192.168.10.23
      - DISABLE_REGISTRATION=true

      # 数据库的配置
      - GITEA__database__DB_TYPE=mysql
      - GITEA__database__HOST=192.168.10.67:3306
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea.2023
      # Cache
      - GITEA__cache__ENABLED=true
      - GITEA__cache__ADAPTER=redis
      - GITEA__cache__HOST=network=tcp,addr=192.168.10.67:6379,password=k3pKWGwxmJnR5MC0AtVi,db=0,pool_size=100,idle_timeout=180
    restart: always
    networks:
      - gitea_network
    volumes:
      - ./data:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /home/git/.ssh/:/data/git/.ssh
    ports:
      - "3000:3000"
      # 为了使转发正常工作，需要将容器（22）的 SSH 端口映射到 docker-compose.yml 中的主机端口 2222。由于此端口不需要暴露给外界，因此可以将其映射到主机的 localhost：
      - "127.0.0.1:222:22"
networks:
  gitea_network:
    external: true
```

## 启动容器

通过下面的命令可以启动gitea容器

```sh
docker-compose up -d
```

我们可以在浏览器中输入`http://服务器IP地址:3000`来打开`Gitea`的Web界面。在首次访问时，`Gitea`要求我们进行一些基本配置。需要根据团队情况修改。

## 生成`SSH key`

其目的用于容器验证主机上的git用户。下面的命令可以完成ssh-key的创建：

```sh
sudo -u git ssh-keygen -t rsa -b 4096 -C "Gitea Host Key"
echo "no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty $(cat /home/git/.ssh/id_rsa.pub)" >> /home/git/.ssh/authorized_keys
chmod 600 /home/git/.ssh/authorized_keys
```

## 配置 SSH passthrough

配置`passthrough`连接到`Gitea`容器的`SSH`映射端口`222`。所以需要编写一个脚本文件，下面的命令可以完成：

```sh
cat >/data/gitea/gitea <<'END'
ssh -p 222 -o StrictHostKeyChecking=no git@127.0.0.1 \
"SSH_ORIGINAL_COMMAND=\"$SSH_ORIGINAL_COMMAND\" $0 $@"
END
# gitea具有执行能力
chmod +x /data/gitea/gitea
# 创建一个软链接
ln -s /data/gitea/gitea /usr/local/bin/gitea
```

## 基于crontab实现自动备份

首先需要实现一个备份的脚本，下面的命令将脚本内容保存到`/data/gitea/backups.sh`：

```sh
cat >/data/gitea/backup.sh <<'END'
#!/bin/bash
# This script creates a .zip backup of gitea running inside docker and copies the backup file to the backup directory
BACKUPDIR=/data/gitea/backups
mkdir -p $BACKUPDIR
echo "Delete older backup..."
find $BACKUPDIR -type f -mtime +9 -name "*.zip" -delete
containerId=$(docker ps -qf "name=tm-gitea")
echo "Create gitea backup inside docker container:$containerId"
docker exec -u git $containerId /bin/bash -c "/app/gitea/gitea dump -c /data/gitea/conf/app.ini --file /tmp/gitea-dump.zip"
echo "Copying backup file from the container:$containerId to the host machine ..."
docker cp $containerId:/tmp/gitea-dump.zip /tmp
echo "Removing backup file in container ..."
docker exec -u git $containerId /bin/bash -c "rm /tmp/gitea-dump.zip"
echo "Renaming backup file ..."
BACKUPFILE=$BACKUPDIR/gitea-dump-$(date +"%Y%m%d%H%M").zip
mv /tmp/gitea-dump.zip $BACKUPFILE
echo "Backup file is available: "$BACKUPFILE
echo "Done."
END
chmod +x /data/gitea/backup.sh
```

需要注意都是，`tm-gitea`时容器名，需要更改为自己的。本脚本默认只保留最近的9个备份文件。

通过执行`/data/gitea/backup.sh`校验脚本是否存在问题。

然后输入命令`crontab -e`进入定时任务编辑页面，将下面的内瓤输入编辑框中。

```plain
#每天lin'c凌晨2点备份
0 2 * * * /data/gitea/backup.sh start
```
