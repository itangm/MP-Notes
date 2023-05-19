# 开发第一个应用程序：HelloWorld

[toc]

## 项目创建

学习任何的编程语言或框架的第一个项目都是HelloWorld，这已经成为默许的情况了。首先，我们需要安装 Vue 的命令行工具。在终端中执行以下命令：

```bash
npm install -g @vue/cli
```

安装完成后，使用以下命令创建一个名为`hello-world`的`Vue`应用程序：

```bash
vue create hello-world
```

然后根据提示选择一些选项来初始化项目，比如选择`Manually select features`并选中`Babel`和`Router`。

我们需要修改`hello-world/src/App.vue`文件，加入如下代码：

```vue
<template>
  <div>
    <h1>Hello World!</h1>
  </div>
</template>
```

最后在终端执行以下命令启动开发服务器：

```bash
cd hello-world
npm run serve
```

这样就可以在浏览器中访问`http://localhost:8080`查看应用程序。

## 项目结构分析

我们来分析`hello-world`项目的结构和代码。以下是该项目的目录结构：

```js
hello-world/
├── node_modules/
├── public/
│   ├── favicon.ico
│   ├── index.html
│   └── robots.txt
├── src/
│   ├── assets/
│   ├── components/
│   ├── router/
│   ├── App.vue
│   └── main.js
├── .gitignore
├── babel.config.js
├── package-lock.json
└── package.json
```

下面是每个文件和目录的作用：

* `node_modules/`: 该目录包含了项目所需的所有依赖包。
* `public/`: 该目录包含了一些静态文件，如`index.html`和`favicon.ico`。其中，`index.html`是`Vue`应用程序的入口文件，它包含了一个`div`元素，`id`为`"app"`，`Vue`会将应用程序渲染到这个元素中。
* `src/`: 该目录是应用程序的主要代码目录。其中，`assets/`目录存放静态资源文件，如图片、样式文件等；`components/`目录存放组件文件；`App.vue`文件定义了应用程序的根组件，该组件包含了应用程序的主要内容；`main.js`是应用程序的入口文件，它初始化`Vue`应用程序并将根组件渲染到页面上。
* `.gitignore`: 该文件定义了`Git`版本控制系统忽略的文件和目录。
* `babel.config.js`: 该文件是`Babel`配置文件，它指定了`Babel`的一些配置选项，用于将`ES6+`的`JavaScript`代码转换为浏览器可以理解的`JavaScript`代码。
* `package.json`: 该文件是应用程序的配置文件，其中包含了应用程序的名称、版本号、依赖包列表等信息。
* `README.md`: 该文件是项目的说明文档，其中包含了项目的简介、安装和使用说明等。

https://www.bilibili.com/video/BV1Rs4y127j8/?p=4&spm_id_from=pageDriver&vd_source=92c1110785c5f29a0d7bc2a75139a53c