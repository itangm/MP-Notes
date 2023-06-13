# Spring Boot启动时加载指定外部依赖、JAR、配置文件

[toc]

## 前言

在之前的笔记中记录了[Spring Boot Maven打包包含外部jar的方式](../05/D101-Spring%20Boot%20Maven%E6%89%93%E5%8C%85%E5%8C%85%E5%90%AB%E5%A4%96%E9%83%A8jar%E7%9A%84%E6%96%B9%E5%BC%8F.md)，但是这次的需求优点不一样，同样是厂家SDK，但是SDK依赖包不是固定的，会因为账号不一样，SDK包含的内置信息不同，而这些配置无法通过SDK提供的开放API调整。所以希望在启动时决定去加载哪些依赖JAR。

## Launcher

`org.springframework.boot.loader.Launcher`类时一个特殊的启动类，是`Spring Boot`可执行JAR的主要入口，它是`Spring Boot jar`文件中实际`Main-Class`，用于设置适当的`URLClassLoader`并最终调用`Spring Boot`项目中定义的`main()`方法。 

`Launcher`有三个实现类（`JarLauncher`、`WarLauncher`、`PropertiesLauncher`），主要用于实现从目录中加载嵌套jar或war文件中的资源（比如`.class`文件）。对于`JarLauncher`、`WarLauncher`，加载路径是固定的，`JarLauncher`在`BOOT-INFO/lib`中加载，而`WarLauncher`在`WEB-INF/lib`和`WEB-INF/lib-provided`中加载。

`PropertiesLauncher`除了在`BOOT-INFO/lib`中加载，还可以通过设置`loader.properties`中的属性名`loader.path`或环境变量`LOADER_PATH`来增加其它的加载未知。

* `loader.path` 配置逗号分隔的`Classpath`类路径，例如`lib,${HOME}/app/lib`，前面的路径优先，类似于`javac`命令中的`-classpath`。
* `loader.home` 用于解析`loader.path`配置的相对路径，默认是`${user.dir}`。

我们可以通过如下配置来选择使用`PropertiesLauncher`：

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <configuration>
        <mainClass>${start.class}</mainClass>
        <layout>ZIP</layout>
    </configuration>
</plugin>
```

默认是根据`<packing>`打包类型(`jar`或`war`）来确定`Launcher`类型，这里是通过`ZIP`配置来选择使用哪个`Launcher`：

* JAR
* WAR
* ZIP：使用`PropertiesLauncher`
* NONE: 不捆绑引导加载程序

打包成功后，我们通过`java -jar -Dloader.path=conf,lib <jarName>.jar`命令来启动程序，则`${user.dir}/lib`中的外部`jar`，`${user.dir}/conf`中的外部配置均会被加载。

更多的信息详见Spring官网文档：https://docs.spring.io/spring-boot/docs/2.7.12/reference/html/executable-jar.html#appendix.executable-jar.nested-jars
