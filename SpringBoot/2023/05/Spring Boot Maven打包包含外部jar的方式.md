# Spring Boot Maven打包包含外部jar的方式

当某个项目需要调用厂家业务SDK，而这个SDK并没有公开在Maven中央仓库，那么在打包部署时通常需要将这些外部jar包打包进可执行的jar文件中。下面给出两个方向的解决方案。

## 外部jar上传到私服

这个方向的解决方案的前提要求公司必须有私服（基本上都会有了）。然后根据外部jar的特点定义一个GAV坐标，最后调用通过本地上传到Maven私服仓库中。下面据介绍了重点部分：

通过下面的命令可以将jar上传到私服中的`3rd party`仓库中。

```sh
mvn deploy:deploy-file -DgroupId=cn.tmkit -DartifactId=tmkit-nb -Dversion=1.0.0 -Dpackaging=jar -Dfile=tmkit-nb-sdk.jar -Durl=http://my-server:8081/content/repositories/thirdparty -DrepositoryId=thirdparty
```

然后就可以在项目中引入上面的GAV坐标了。跟正常的使用没有任何区别。

## 在打包层面解决

意思就是在Maven打包的时候，通过各种方式告诉Maven，我需要将额外的jar打包进来，别给它整丢了。这里就会有非常的多的实现方式。我这里列举的是我比较熟悉的方式方法，个人认为也是非常简单的了。

### 修改`spring-boot-maven-plugin`标签

1. 将外部jar添加到项目中

  比如我们统一将外部jar存放到项目的`src/libs`目录下。

2. 声明Maven依赖

  然后在项目中`pom.xml`文件中的`dependencies`标签下增加一个依赖引入，内容如下所示：

  ```xml
  <dependency>
      <groupId>cn.tmkit</groupId>
      <artifactId>tmkit-nb</artifactId>
      <version>1.0.0</version>
  </dependency>
  ```
GAV坐标名根据实际外部SDK更改下，具有见名知意即可。
  

3. 修改`spring-boot-maven-plugin`的配置

  项目中`pom.xml`默认的打包配置一般如下所示：

  ```xml
  <plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
  </plugin>
  ```

  只要改为下面的配置方式就可以将`<scope>`值为`system`打包进来了。

  ```xml
  <plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
      <configuration>
          <includeSystemScope>true</includeSystemScope>
      </configuration>
  </plugin>
  ```

### 修改`resources`标签

1. 将外部jar添加到项目中

  与修改`spring-boot-maven-plugin`标签相同。

2. 声明Maven依赖

  与修改`spring-boot-maven-plugin`标签相同。

3. 修改`resources`配置

  项目中`pom.xml`的`<build>`下的`<resources>`增加下面的配置：

  ```xml
  <!--外部jar包地址-->
  <resource>
      <directory>${basedir}/src/lib</directory>
      <targetPath>BOOT-INF/lib/</targetPath>
      <includes>
          <include>**/*.jar</include>
      </includes>
  </resource>
  ```

**采用这种方式需要特别注意的一个点：在定义GAV坐标时，`version`的值不能带有`SNAPSHOT`，不然这个依赖不会自动打包进来。我在这里卡住了一天。**



