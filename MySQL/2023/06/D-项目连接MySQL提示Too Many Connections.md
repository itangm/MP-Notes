# 项目连接MySQL提示Too Many Connections

## 问题现象

在项目启动时突然出现如下的错误：

```log
java.sql.SQLNonTransientConnectionException: Too many connections
        at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:110)
        at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)
        at com.mysql.cj.jdbc.ConnectionImpl.createNewIO(ConnectionImpl.java:829)
        at com.mysql.cj.jdbc.ConnectionImpl.<init>(ConnectionImpl.java:449)
        at com.mysql.cj.jdbc.ConnectionImpl.getInstance(ConnectionImpl.java:242)
```

## 问题原因

看到这种错误基本不慌，因为之前就碰到过这个问题，只是这次部署MySQL还是忘记修改**最大连接数**了。

MySQL8允许客户端并发连接最大值为151，一旦服务变多了之后这个很容易超出，一般将该参数设置为500-1000之间，当然如果你的服务器性能很好，可以往上调整。

我们可以通过下面的命令查询当前MySQL服务器的最大并发连接数是多少：

```sh
show variables like 'max_connections';
```

## 更改配置

如果是通过`yum`此类的按照，那么MySQL的配置文件在`/etc/my.cnf`，如果是Docker部署的，记得把这个配置文件映射出来。

```sh
[mysqld]
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql
# 增加了这一行
max_connections=1000

character_set_server=utf8
lower_case_table_names=1
group_concat_max_len=1024000
log_bin_trust_function_creators=1

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock
```

https://zhuanlan.zhihu.com/p/550812951
