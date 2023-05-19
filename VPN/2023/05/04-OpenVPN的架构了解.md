# OpenVPN的架构了解

[toc]

## 工作机制

`OpenVPN`采用了`TUN/TAP`虚拟网络驱动程序技术，它是通过软件的方式来模拟出网络设备。`TAP`类型的设备作用是模拟以太网设备（网桥），是`OSI`模型中的第二层，实现的以太网帧；那`TUN`类型的设备作用实现IP数据包（与路由协同），是`OSI`模型中的第三层。 下面是一个简易图形：

![]()

通过图中得知，`TUN/TAP`这两个设备是和用户空间的特定应用程序、OpenVPN是连接在一起的。

### 数据发送

也就是数据从应用程序到物理网络的过程。

https://www.youtube.com/watch?v=r8-OQE7B3bM&t=3s

https://app.diagrams.net/#Hitangm%2Fdraw.io-files%2Fmain%2FOpenVPN%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%9B%BE.drawio




## 加密过程

## 身份验证

## 网络

## 安全

## 可扩展性
