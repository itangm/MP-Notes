# 什么是Spring Boot

`Spring Boot`是由`Pivotal`团队提供的全新框架，其设计目的是用来简化`Spring`应用的初始化搭建以及开发过程。该框架使用了特定的方式来进行配置，从而使得开发人员不再需要定义样板化的配置。

上面是官方术语，那么下面是个人的理解，`Spring Boot`并不是什么新的框架（相对于`Spring`等），可以认为是一个工具包，为了方便快速用`Spring`搭建一个项目，所以`Spring Boot`整合了自己以及市面上常见的框架，封装成一个个工具包，想用到时候引入进来就可以了。

`Spring Boot`的出现我觉得还有一个原因是`Pivotal`团队发现了`Spring`使用起来已经越来越复杂了，所以创造了`Spring Boot`。

## 使用`Spring Boot`的好处

简单、快速、方便！

如果按照之前的方式搭建一个`Spring Web`项目的步骤大致流程如下：

1. 配置`web.xml`，用来加载`Spring`和`Spring MVC`（可能已经很多人不记得了标签😂）
2. `Spring`和`Spring WebMVC`的依赖包
3. 数据库的依赖
4. Mybatis的依赖
5. 配置数据库连接、配置`Spring`事务
6. 配置配置文件的读取
7. 静态资源的过滤
8. 配置日志文件
9. Tomcat的配置
10. ...

可以看到的是流程的繁琐于重复，那么使用了`Spring Boot`之后简化了很多。下图表达了`Spring Boot`的有多爽：

![](./images/00-lihaile.jpeg)

下面再来总结下`Spring Boot`的优点：

* 避免了在`Spring`中进行复杂的XML配置
* 非常简单容易搭建`Spring`程序
* 包括了嵌入式Servlet容器
* 基于注解的开发
* 简化了依赖管理


