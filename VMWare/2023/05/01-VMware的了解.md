# VMware的了解

## 简单的了解

`VMware`是一家位于美国的软件公司，成立于1998年，这家公司的名字来源于它的核心产品————“虚拟化软件”（Virutal Machine Sofware）。

我们需要知道的是，使用VMware的前提必须电脑配置过得去，不然运行VMware会让你回到2010年代前。

## 产品列表

1. 桌面虚拟化

  `VMware Workstation`和`VMware Fusion`是两款广受好评的桌面虚拟化软件。它们允许用户在一台计算机上同时运行多个操作系统。这对于开发人员、测试人员和折腾人员非常有用。

2. 服务器虚拟化

  `VMware vSphere`是一款专业的服务器虚拟化平台，广泛应用于企业和数据中心。vSpere可用有效地管理和分配服务器资源，提高服务器的运行效率，降低企业成本。

3. 网络虚拟化

  `VMware NSX`是一款网络虚拟化平台，可以实现网络资源的动态分配和管理。

4. 云计算

  `VMware Cloud`是一套云计算解决方案。

## 相对个人

对于我们个人来说，我们主要还是了解桌面虚拟化基本上就可以了，上面我记录到有两款软件，实际上是有三款的，下面我们分别来了解下：

1. `VMware Workstation`

  适用于WIndows和Linux操作系统的虚拟化软件，具有丰富的功能和更高的性能，可以创建、运行和管理多个虚拟机。`VMware Workstation`包含了`VMware Player`。

2. `VMware Fusion`

  适用于MacOS操作系统的虚拟化软件，具有与`VMware Workstation`相似的功能，可以创建、运行和管理多个虚拟机。

3. `VMware Player`

  适用于WIndows和Linux操作系统的**免费**虚拟化软件，功能相对较少，不能自定义网络。
  
  针对个人推荐优先`VMware Player`，因为其无需破解、无需激活、无需注册码，非常省事，无需想办法如何白嫖`VMware Workstation`。

## `VMware Player`的历史

2008年6月6日，`VMware`发布了`VMware Player 1.0`，功能较`VMware Workstation`简单，但独立于`VMware Workstation`之外。

2015年，`VMware Workstation`发布12版，`VMware Player`转型为`VMware Workstation`的免费版并更名为`VMware Workstation Player`，`VMware Workstation`的付费版更名为`VMware Workstation Pro`。

## 相对企业

如果企业简单使用`VMware`，可以试用`VMware ESXi`，它是`VMware vSphere`的核心组件之一，用于构建和管理虚拟化环境。它是一款轻量级的虚拟化操作系统，可以直接安装在物理服务器上，将物理服务器转为虚拟化服务器。
