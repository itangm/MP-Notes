# 对比Nginx的几个版本

Nginx是一个流行的Web服务器和反向代理服务器，有多个开源版本可供选择。在这里，我会对比Nginx的几个开源版本，并分享一些我的看法。

## `Nginx Open Source`

* 官网：https://nginx.org/en/docs/
* 介绍：`Nginx Open Source`是`Nginx`官方的开源版本，拥有大量的文档和社区支持。它的速度快、内存占用少、可扩展性高等特点，使其成为Web服务器和反向代理的首选。人们对`Nginx Open Source`的评价非常高，认为它是一款出色的软件。

## `Nginx Plus`

* 官网：https://www.nginx.com/products/nginx/
* 介绍：由`Nginx`官方提供的商业版本，提供了更多的功能，如高级负载均衡、实时监控和支持商业SLA。

## `OpenResty`

* 官网：https://openresty.org/cn/
* 介绍：`OpenResty`是一个基于`Nginx`的Web平台，使用`Lua`脚本语言扩展`Nginx`的功能。`OpenResty`可以用于构建高性能的Web应用程序、API和网关。它的主要优点是灵活性高、扩展性好、易于编写和维护`Lua`脚本。此外，`OpenResty`还提供了许多常用的`Lua`模块和库，可以快速构建复杂的Web应用。

## `Tengine`

* 官网：http://tengine.taobao.org/documentation_cn.html
* 介绍：`Tengine`是由淘宝公司开发的一个基于`Nginx`的Web服务器，它使用了许多优化技术，如动态模块加载、内存池管理和多线程处理等。`Tengine`的主要优点是性能高、可靠性好、支持大规模并发连接。此外，`Tengine`还支持HTTP/2和SSL加速等高级功能。

## 表格对比

| 版本  |  优点 | 适用场景 |
|---|---|---|
| `Nginx Open Source` | 速度快、内存消耗少、可配置性高、活跃的社区提供许多有用的模块和插件 | 构建高流量、高并发的Web应用程序和网站 |
| `Nginx Plus` | 性能和可靠性出色，24x7的技术支持和服务 | 大型且不差钱的企业级应用的首选 |
| `OpenResty` | 灵活性高、扩展性好、易于编写和维护Lua脚本，支持动态模块加载 | 处理复杂的业务逻辑、高并发的API和网关 |
| `Tengine` | 性能出色、可扩展性高、支持多种安全功能和模块 | 高流量、高并发的Web应用程序和网站 |

总的来说，各个版本在用人群非常多，所以也不需要纠结到底应该使用哪个？一般来说`Nginx Open Source`完全够用，只有需要在前端网关做一点事情，那么才考虑的事情。
