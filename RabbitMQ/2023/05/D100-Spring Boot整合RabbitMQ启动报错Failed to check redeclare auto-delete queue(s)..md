# Spring Boot整合RabbitMQ启动报错Failed to check redeclare auto-delete queue(s)

**主要还是粗心导致的，在此记录下。**问题现象是：Spring Boot启动的时候，出现错误的信息如下所示：

```java
[xxx:10.200.2.4:8080] 2023-05-18 17:24:36.755 ERROR 7 [] [org.springframework.amqp.rabbit.RabbitListenerEndpointContainer#0-1] o.s.a.r.l.SimpleMessageListenerContainer  Failed to check/redeclare auto-delete queue(s).
org.springframework.amqp.AmqpIOException: java.io.IOException
        at org.springframework.amqp.rabbit.support.RabbitExceptionTranslator.convertRabbitAccessException(RabbitExceptionTranslator.java:70)
        at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.createBareConnection(AbstractConnectionFactory.java:602)
        at org.springframework.amqp.rabbit.connection.CachingConnectionFactory.createConnection(CachingConnectionFactory.java:725)
        at org.springframework.amqp.rabbit.connection.ConnectionFactoryUtils.createConnection(ConnectionFactoryUtils.java:252)
        at org.springframework.amqp.rabbit.core.RabbitTemplate.doExecute(RabbitTemplate.java:2210)
        at org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTemplate.java:2183)
        at org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTemplate.java:2163)
        at org.springframework.amqp.rabbit.core.RabbitAdmin.getQueueInfo(RabbitAdmin.java:463)
        at org.springframework.amqp.rabbit.core.RabbitAdmin.getQueueProperties(RabbitAdmin.java:447)
        at org.springframework.amqp.rabbit.listener.AbstractMessageListenerContainer.attemptDeclarations(AbstractMessageListenerContainer.java:1939)
        at org.springframework.amqp.rabbit.listener.AbstractMessageListenerContainer.redeclareElementsIfNecessary(AbstractMessageListenerContainer.java:1914)
        at org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer$AsyncMessageProcessingConsumer.initialize(SimpleMessageListenerContainer.java:1377)
        at org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer$AsyncMessageProcessingConsumer.run(SimpleMessageListenerContainer.java:1223)
        at java.lang.Thread.run(Thread.java:855)
        at com.alibaba.wisp.engine.WispTask.runOutsideWisp(WispTask.java:299)
        at com.alibaba.wisp.engine.WispTask.runCommand(WispTask.java:274)
        at com.alibaba.wisp.engine.WispTask.access$100(WispTask.java:53)
        at com.alibaba.wisp.engine.WispTask$CacheableCoroutine.run(WispTask.java:241)
        at java.dyn.CoroutineBase.startInternal(CoroutineBase.java:62)
Caused by: java.io.IOException: null
        at com.rabbitmq.client.impl.AMQChannel.wrap(AMQChannel.java:129)
        at com.rabbitmq.client.impl.AMQChannel.wrap(AMQChannel.java:125)
        at com.rabbitmq.client.impl.AMQChannel.exnWrappingRpc(AMQChannel.java:147)
        at com.rabbitmq.client.impl.AMQConnection.start(AMQConnection.java:439)
        at com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.java:1225)
        at com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.java:1173)
        at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.connectAddresses(AbstractConnectionFactory.java:640)
        at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.connect(AbstractConnectionFactory.java:615)
        at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.createBareConnection(AbstractConnectionFactory.java:565)
        ... 17 common frames omitted
Caused by: com.rabbitmq.client.ShutdownSignalException: connection error; protocol method: #method<connection.close>(reply-code=530, reply-text=NOT_ALLOWED - vhost /prod not found, class-id=10, method-id=40)
        at com.rabbitmq.utility.ValueOrException.getValue(ValueOrException.java:66)
        at com.rabbitmq.utility.BlockingValueOrException.uninterruptibleGetValue(BlockingValueOrException.java:36)
        at com.rabbitmq.client.impl.AMQChannel$BlockingRpcContinuation.getReply(AMQChannel.java:502)
        at com.rabbitmq.client.impl.AMQChannel.privateRpc(AMQChannel.java:293)
        at com.rabbitmq.client.impl.AMQChannel.exnWrappingRpc(AMQChannel.java:141)
        ... 23 common frames omitted

```

一开始是按照标题的错误，也就是`Failed to check/redeclare auto-delete queue(s).`查找答案的，给出的答案主要是如下两类：

* 端口`5672`是否开放
* 账号和密码是否正确

## 根本原因

`reply-code=530, reply-text=NOT_ALLOWED - vhost /prod not found, class-id=10, method-id=40`才是问题的根本原因，项目中配置的虚拟host，没有在RabbitMQ后台配置，究其原因主要是两边配置不一致，我这里的不一致的原因是在RabbitMQ管理后台忘记`/`了。
