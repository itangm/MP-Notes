# 什么是VPN

[toc]

## 简介

`VPN`，全称为“`Virtual Private Network`”，即虚拟私人网络。它是一种利用公共网络（如互联网）建立安全、加密连接的技术，用于实现远程访问、保护隐私和数据安全等功能。

![](./images/00-internet-on-vpn.png)

## VPN分类

根据VPN的实现方式，可以将其分为以下几类：

### 1、远程访问VPN

远程访问VPN是指在公共网络上建立安全的通信链路，使远程用户能够像在本地一样访问公司内部网络资源。该种VPN常用于移动办公、外派工作和远程学习等场景。

### 2、网络对接VPN

网络对接VPN是指将两个或多个局域网连接起来，使得这些局域网之间的计算机能够互相访问。该种VPN常用于分支机构间的互联、企业间的互联等场景。

### 3、网关到网关VPN

网关到网关VPN是指通过两个安全网关之间的加密通道来实现两个网络的安全通信。这种VPN主要用于公司内部的不同部门之间的互联，或者不同企业之间的安全通信。

### 4、客户端到网关VPN

客户端到网关VPN是指客户端计算机通过公共网络与VPN网关建立加密通道，从而能够访问公司内部网络资源。该种VPN常用于移动办公等场景。

远程访问VPN和客户端到网关VPN的区别在于应用场景的不同，前者适用于远程用户访问公司内部资源的场景，后者适用于公司内部网络设备之间进行安全通信的场景。

## VPN优势

VPN的优势主要体现在以下几个方面：

### 1、加密传输

VPN通过建立安全通道，对数据进行加密传输，避免了数据在传输过程中被窃取、篡改或监听的风险，保障了用户数据的安全性。

### 2、访问控制

VPN可以实现远程用户身份认证和授权，对远程访问进行访问控制，保障了网络安全。

### 3、防火墙穿越

VPN可以穿越防火墙等安全设备，通过加密通道来建立安全的连接，实现远程访问内部网络资源的功能。

### 4、节省成本

VPN能够通过公共网络建立加密连接，避免了搭建专用线路的成本，节省了企业的网络成本。

## VPN关键技术

VPN的实现涉及到以下几个关键技术：

### 隧道技术

VPN通过隧道技术来实现加密通道的建立，隧道技术将待传输的数据包封装在安全的隧道中，通过公共网络传输，到达目标网络后再解包还原成原始数据包。

### 加密技术

VPN通过加密技术来保障数据传输的安全性。常见的加密算法有DES、3DES、AES等，同时还需要使用密钥管理技术来保障密钥的安全性。

![](./images/01-vpn-encrypt-data.png)

#### 身份认证

VPN网关对接入的VPN用户进行身份认证，保证接入的用户都是合法用户。

#### 协议技术

VPN通过协议技术来实现安全通信。常见的VPN协议有PPTP、L2TP、IPSec等。

#### 数据验证

通过数据验证技术验证报文的完整性和真伪进行检查，防止数据被篡改。

![](./images/02-vpn-data-validation.png)

