# 接口参数返回Long类型导致数据问题

[toc]

## 问题场景

在使用`Spring Boot`定义接口返回参数时，部分同学将参数类型定义为`Long`，在前后端联调的时候发现，前端收到的数据于后端返回的数据不一致，像是被篡改了一样。

## 问题分析

经过分析，发现前端接收的数据发生变化的原因是`Java`和`JavaScript`之间的数据类型转换有关，**具体来说，可能存在精度丢失的问题。**`Java`中`Long`占用8个字节，而`JavaScript`中的`Number`类型只能标识53位整数，也就是说`JavaScript`数值型最大值为`2^53-1 = 9007199254740991`，而`Java`中`Long`最大值为`z^64-1`。显然发生了数据溢出的问题，会出现无法预知的结果。

## 解决方案

### 返回类型改为字符串类型

```java
@RestController
@RequestMapping("/api")
public class ExampleController {
    @GetMapping("/example")
    public String example() {
        long number = 1234567890123456789L;
        return String.valueOf(number);
    }
}
```

本方案需要每个接口都检查一遍，查看返回参数中是否定义了`Long`类型。

### 修改配置项使全局生效

这里以`Spring Boot`工程为例，并且使用了`Jacskon`库（默认）。请参考以下配置文件的示例：

```yaml
spring:
  jackson:
    generator:
      write-numbers-as-strings: true

```

除了配置文件的方式，也可以通过自定义一个`ObjectMapper`类进行配置，如下所示：

```java
@Configuration
public class JacksonConfig {

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return builder -> {
            builder.failOnUnknownProperties(false);
            builder.serializerByType(Long.class, ToStringSerializer.instance);
            // 基本类型long
            builder.serializerByType(Long.TYPE, ToStringSerializer.instance);
            builder.serializerByType(BigInteger.class, ToStringSerializer.instance);
            builder.serializerByType(BigDecimal.class, ToStringSerializer.instance);
            builder.serializationInclusion(JsonInclude.Include.NON_NULL);
        };
    }

}
```

### 前端兼容，采用三方库`BigNumber.js`进行精度的处理

前端也可以支持大数的，不过需要通过三方库`BigNumber.js`支持，可以处理任意大小的整数和浮点数。

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.0/bignumber.min.js"></script>
```

然后，在处理前端接收到的数据时，可以使用BigNumber.js库的方法来将字符串转换为高精度数字。

```javascript
const number = new BigNumber("1234567890123456789");
console.log(number.toString()); // 输出 1234567890123456789
```
