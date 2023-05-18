# Nginx反向代理RabbitMQ管理控制台/丢失

[toc]

## 问题现象

RabbitMQ所在的服务器没有外网，同时15672端口也不对外开放，所以通过Nginx反向代理解决问题，Nginx的配置文件如下：

```nginx
location /rabbitmq/ {
    proxy_pass http://192.168.10.193:15672/; 
    proxy_set_header Host $http_host; 
    proxy_set_header X-Real-IP $remote_addr; 
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
    proxy_set_header REMOTE-HOST $remote_addr; 
    proxy_set_header Upgrade $http_upgrade; 
    proxy_set_header Connection "upgrade"; 
    proxy_http_version 1.1; 
    add_header Cache-Control no-cache; 
}
```
通过浏览器输入`http://192.168.10.193:rabbitmq/`是可以正常访问的。但是后面在使用创建`虚拟host`的时候出现了如下两个现象：

1. 无法创建形如`/dev`此类的虚拟host

  创建`/dev`得到的结果`dev`，也就是丢失了`/`。但是通过`http://192.168.10.193:15672/`创建是正常的，所以说明一定是Nginx代理出现了问题。

2. 访问`虚拟host`比如`/dev`会出现404问题

  比如访问`http://192.168.10.193/rabbitmq/#/vhosts/%2Fprod`直接提示`404 Not Found`，问题也是由于Nginx代理出现了问题。

  ## 问题原因

  `/`是路径分隔符，如果作为值存在的话，会进行URL编码成`%2F`。Nginx在反向代理时转换失败了，因为这些字符经过Nginx被转为`/`。比如上面的路径地址`http://192.168.10.193/rabbitmq/#/vhosts/%2Fprod`到了RabbitMQ之后得到的请求地址为`http://192.168.10.193:9000/#/vhosts//prod`，而正确的应该是`http://192.168.10.193:15672/#/vhosts/%2Fprod`。

  ## 解决方案

  需要用到Nginx的变量提取、URL重写等能力，最终可用的是再增加一个配置：

  ```nginx
  location ^~ /rabbitmq/api/ {
    rewrite ^ $request_uri;
    rewrite ^/rabbitmq/api/(.*) /api/$1 break;
    return 400;
    proxy_pass http://192.168.10.193:15672$uri; 
    proxy_set_header Host $http_host; 
    proxy_set_header X-Real-IP $remote_addr; 
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
    proxy_set_header REMOTE-HOST $remote_addr; 
    proxy_set_header Upgrade $http_upgrade; 
    proxy_set_header Connection "upgrade"; 
    proxy_http_version 1.1; 
    add_header Cache-Control no-cache; 
}
```
