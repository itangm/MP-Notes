# Java开源项目发布Maven中央仓库的几种选择

[toc]

如何将自己的开源项目发布到Maven中央仓库，让其他人通过依赖可以使用你的项目，我想很多人有过这个想法。
那本次我打不算并不详细分析某一种方式的操作细节，而是来看下有哪几种选择可以将开源项目发布公网。

## MavenCentral

MavenCentral也叫做Maven中央仓库，是使用最为广泛的一个公共仓库，目前，MavenCentral的官方审核渠道是通过Sonatype的OSSRH服务进行审核和发布。这是因为MavenCentral的管理者是Sonatype公司，只有经过Sonatype审核的软件才能发布到Maven中央参仓库。

## JitPack

JitPack是一种基于GitHub代码仓库的自动化构建和发布工具，可以帮助我们将代码打包成Maven包，并将其发布到Maven中央仓库。使用JitPack，你只需要将项目代码托管在GitHub上（目前也支持Gitee），并在`build.gradle`或`pom.xml`中添加相应的配置，即可将项目构建并发布到Maven中央仓库。JitPack还支持自动版本管理和依赖关系解析，可以方便的管理项目依赖关系。

## Gradle Plugin Portal（只存放Gradle插件）

Gradle Plugin Portal是一个专门发布Gradle插件的仓库，可以将吵架呢发布到Maven中央仓库和Gradle Plugin Portal。使用Gradle Plugin Portal，你只需要编写一个Gradle插件，并将其打包成Maven包，然后将其上传到Gradle Plugin Portal。Gradle Plugin Portal支持版本管理和依赖关系解析，可以方便的管理插件依赖关系。

## JFrog Bintray（已下线）

JFrog Bintray 是一个通用的分发平台，可以将软件包分发到自己的仓库的同时还可以同步给Maven中央仓库，可惜的是JFrog 已经宣布将于2021年5月1日停止 Bintray 和 JCenter 服务。

## 代理镜像

目前国内的各大厂商都是Maven的镜像代理，主要是因为有时候Maven中央仓库抽风，下载的时候比较慢。截止我所有了解的目前国内没有做类似于Bintray的方式。毕竟这是一个公益性的服务，不赚钱还烧钱的。

