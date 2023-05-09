# 00-什么是RabbitMQ？

[toc]

## 名词解释

* `MQ` = `Message Queue`，中文名称叫做消息队列
* `AMQP` = `Advanced Message Queue Protocol`，中文名称叫做高级消息队列协议，是应用层协议的一个开放标准，为面向消息的中间件设计。

## 简介

`RabbitMQ`是一个广泛使用的消息服务器，采用`Erlang`语言编写，是一种开源的，实现了`AMQP`协议的的消息中间件。

`RabbitMQ`最初起源于金融系统，它的性能及稳定性都非常出色。

## 相关网址

* RabbitMQ Website https://rabbitmq.com/
* RabbitMQ Github  https://github.com/rabbitmq
* AMQP Website     https://www.amqp.org/

## 消息中间件

简单来理解消息中间件就是保存数据的一个容器（服务器），可以用于两个系统之间的数据传递。

消息中间件一般有三个重要角色：生产者、消费组和消息代理（消息队列、消息服务器）。

![](./images/mq-producer-consumer.png)

## 常用的消息中间件

目前比较主流的几个消息中间件如下：

* `RabbitMQ`
* `Kafka`（大数据领域）
* `RocketMQ`（阿里巴巴开源，国内特别火），目前已经贡献给Apache
* `Pulsar`（最近流行起来的）

## RabbitMQ的特点

* **高度可靠性**：`RabbitMQ`有多种机制来保证可靠性，包括持久化存储、消息确认机制、备份队列等。
* **高考可扩展性**：`RabbitMQ`可以通过添加节点来扩展负载容量，它支持多种协议、多语言客户端，还可以通过插件实现自定义功能。
* **消息传递的多样化**：`RabbitMQ`支持多种消息传递方式，包括点对点（一对一）、发布订阅（一对多）、消息路由、RPC等。
* **高可用性和可恢复性**：`RabbitMQ`支持多种高可用性架构，包括镜像队列、集群等，这些机制都能够保证在节点宕机等情况下消息系统的可用性和可恢复性。
