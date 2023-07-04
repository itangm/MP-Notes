# 项目中shell脚本在Windows下换行符问题

[toc]

## 前言

在前面的分享笔记[Docker构建镜像启动报no such file or directory问题](https://mp.weixin.qq.com/s/Ro7ApvGVeddHlrknXif8nA)就提到了不同操作系统的文件编码（即换行符）处理方式不一样，导致Windows下打包放到Linux直接崩了。上次虽然提供了一个修复方式，但是那种方式比较傻而且不自动，最最关键的是Git+IDE组合默认情况下会自动将`LF`转为`CRLF`。

## EditorConfig

上面的问题肯定历史上早就有人碰到了，所以`EditorConfig`诞生了。`EditorConfig`是一个跨平台的规范，它提供了一种在不同的编辑器和IDE中创建和共享代码格式化选项的方法；它通过在项目中添加一个名为`.editorconfig`的配置文件来实现的。**简单来说`EditorConfig`屏蔽了IDE和不同平台的差异性。**

`EditorConfig`官网是：`https://editorconfig.org/`

`EditorConfig`是一个规范，需要不同的编辑器支持，不过好在目前大部分编辑器都支持的，比如：

* Visual Studio Code
* Sublime Text
* IntelliJ IDEA
* Vim
* 更多详见官方

## EditorConfig语法

`EditorConfig`采用`INI`文件格式来定义代码格式化选项。每个`EditorConfig`文件又多个部分组成，每个部分都一个文件类型或通配符和一组键值对，用于指定该文件类型的格式化选项。

说一千道一万，还不如一共语法示例更加有视觉冲突和定义：

```ini
# EditorConfig file

# top-most EditorConfig file
root = true

# 设置所有的文件的缩进位4个空格
indent_style = space
indent_size = 4

# 设置JAVA文件的缩进为tab
[*.java]
indent_style = tab

# 设置shell脚本缩进为2个空格，并使用LF作为换行符
[*.sh]
indent_style = space
indent_size = 2
end_of_line = lf
```

上面的示例基本上就是所有的语法了，下面介绍所有的键值对语法：

* `indent_style`：指定缩进样式，可以是`tab`或`space`；
* `indent_size`：指定缩进大小，通常为`2`或`4`个空格；
* `tab_width`：指定tab的宽度，通常为`2`或`4`个空格；
* `end_of_line`：指定换行符，可以是`lf`、`cr`或`crlf`。
* `charset`：指定字符集，可以是`utf-8`、`utf-8-bom`或`latin1`；
* `trim_trailing_whitespace`：指定是否删除行末尾的空白字符，可以是`true`或`false`；
* `insert_final_newline`：指定是否在文件末尾插入空行，可以是`true`或`false`。

`EditorConfig`还支持通配符，可以使用`*`、`**`和`?`等通配符来匹配文件名或路径。例如：`*.java`匹配所有以`.java`结尾的文件，`**/*.js`匹配所有后缀为`.js`的文件，包括子目录中的文件。

还有一个键值对`root = true`，`EditorConfig`插件会根据打开文件的所在目录以及父目录一直搜索`.editorconfig`配置文件，直到有一个配置文件配置了`root = true`，那么`EditorConfig`插件就会停止往上搜索`.editorconfig`配置文件。

## 在用的`EditorConfig`分享

下面是我在公司要求统一使用的`.editorconfig`配置文件内容，可以供大家参考，也可以提供更好的模板：

```ini
# EditorConfig For Java
root = true

[*]
charset = utf-8
insert_final_newline = true
indent_style = space
indent_size = 4
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false

[*.sh]
end_of_line = lf

[{*.yml,*.yaml,*.json}]
indent_size = 2
```

