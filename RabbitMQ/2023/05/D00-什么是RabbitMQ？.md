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

* RabbitMQ
* Kafka（大数据领域）
* RocketMQ（阿里巴巴开源，国内特别火），目前已经贡献给Apache
* Pulsar（最近流行起来的）
