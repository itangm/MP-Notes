# Nacos2.2.x碰到的坑和注意点集合

[toc]

## 1、坑：`protocol-raft.log`日志出现`Fail to get leader of group naming_service_metadata, null`

首先这个不影响使用，也就是说可能 一般情况下不会发现这个问题，我是在排查问题时查看日志发现`protocol-raft.log`文件非常大，查看才发现不停地在打印如下错误信息：

```log
java.lang.IllegalStateException: Fail to get leader of group naming_service_metadata, null
        at com.alipay.sofa.jraft.core.CliServiceImpl.getPeers(CliServiceImpl.java:631)
        at com.alipay.sofa.jraft.core.CliServiceImpl.getPeers(CliServiceImpl.java:524)
        at com.alibaba.nacos.core.distributed.raft.JRaftServer.registerSelfToCluster(JRaftServer.java:353)
        at com.alibaba.nacos.core.distributed.raft.JRaftServer.lambda$createMultiRaftGroup$0(JRaftServer.java:264)
        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
        at java.util.concurrent.FutureTask.run(FutureTask.java:266)
        at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$201(ScheduledThreadPoolExecutor.java:180)
        at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:293)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at java.lang.Thread.run(Thread.java:750)
2023-07-18 16:25:22,407 ERROR Failed to join the cluster, retry...
```

出现这个错误表示很懵逼，因为我是`standalone`模式启动的，根本没用到集群模式。**经过对比发现通过容器启动没有开放`7848`端口，导致Nacos不停的在放日志。**

> 解决方案：开放`7848`端口，重启Nacos服务。

## 2、坑：订阅者列表的应用显示为`unknown`

在Nacos控制台查看订阅者列表的订阅信息，发现应用名一列的信息都是`unknown`，这样非常的不友好，看不出来是哪个应用订阅了该服务。

> 解决方案：在应用启动时增加参数配置`-Dproject.name=xxx`

我在Github上的issue看到好些人建议使用`spring.application.name`作为应用名而不是`project.name`，但是到目前`2.2.0`版本还是原来的。

## 3、注：Nacos客户端日志目录调整

Nacos客户端的默认日志目录为家目录，如果是Docker部署的话，强烈建议更改为项目日志目录，这样无需进入容器查看日志，当出现问题的时候。

> 解决方案：在应用启动时增加启动参数：`-DJM.LOG.PATH=/app/logs`

## 4、坑：Nacos不自动注册服务、无法发现服务

暂时不知道原因，目前通过重启应用可以解决。

## 5、注：Nacos无限重启

可能的情况是内存给的不足，导致无限重启，一般在Docker部署时容易出现，当给的内存资源较少时。

> 解决方案：扩大内存，或则调整Nacos的配置，降低内存占用。

