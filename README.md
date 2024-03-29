# QuickOn 应用工具箱

[![GitHub Workflow Status](https://github.com/quicklyon/template-toolkit/actions/workflows/docker.yml/badge.svg)](https://github.com/quicklyon/template-toolkit/actions/workflows/docker.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/template-toolkit?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/template-toolkit?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/template-toolkit?style=flat-square)

通过该工具，可以快速生成QuickOn规范的应用，并提供了应用维护的工具。

## 一、安装工具箱命令

```bash
docker run --rm -v /usr/local:/quickon easysoft/template-toolkit install
```

执行安装后，会将一些工具安装至本机的 `/usr/local/sbin` 目录下，主要以 `q-*` 开头的脚本文件为主。

## 二、初始化应用镜像源码

### 第一步：初始化应用元数据

```bash
mkdir demo-docker
cd demo-docker
# q-init-json <应用名称> <镜像版本可省缺,默认debian-11,可选apline>
q-init-json "ZenTao" "debian-11"
```

执行完命令后，会在当前目录生成 `app.json` 文件，这个文件需要根据具体的应用来修改，如下是示例修改的内容：

```diff
-     "Home": "https://<homepage>/",
+     "Home": "https://www.zentao.com/",

-     "Maintainer": "maintainer maintainer@email.com",
+     "Maintainer": "zhouyueqiu zhouyueqiu@easycorp.ltd",

-     "GitUrl": "https://github.com/<organization>/<app>",
+     "GitUrl": "https://github.com/easysoft/zentaopms",

-     "InstallDocUrl": "https://www.qucheng.com/app-install/zentao-install-<number>.html",
+     "InstallDocUrl": "https://www.qucheng.com/app-install/zentao-install-1231.html",
```

> **说明**
>
> - init-json 命令支持2个参数：
>   - 参数1: 应用名称
>   - 参数2: 镜像系统，目前支持  `debian-11` 和 `alpine`

### 第二步：生产应用模板文件

```bash
cd demo-docker
q-init-app

# 执行命令后，会进行模板初始化的操作，以下是输出内容：
14:41:29.61 INFO  ==> + Copy template directorys ...
 14:41:29.61 INFO  ==>  Prepare [ ./.github ] directory
 14:41:30.62 INFO  ==>  Prepare [ ./.template ] directory
 14:41:32.05 INFO  ==>  Prepare [ ./debian/prebuildfs ] directory
 14:41:33.06 INFO  ==>  Prepare [ ./debian/rootfs ] directory
 14:41:34.07 INFO  ==> + Render templates...
 14:41:34.07 INFO  ==>  Render github workflows config file [docker.yml]
 14:41:34.08 INFO  ==>  Render [ VERSION ] file
 14:41:35.11 INFO  ==>  Render [ Dockerfile ] file
 14:41:36.14 INFO  ==>  Render [ docker-compose.yml ] file
 14:41:37.17 INFO  ==>  Render [ Makefile ] file
 14:41:38.20 INFO  ==>  Preview Render [README.md] based on [document template files]
```

### 第三步：完善文档信息

文档模板目录是 `.template` 目录结构:

```bash

.template
├── app-desc.md          # 应用基础描述内容
├── app-envs.md          # 应用环境变量内容
├── app-extra-info.md    # 应用附加描述内容
├── app.json             # * 应用基础信息定义
├── make-extra-info.md   # make命令特殊说明
├── readme.md.tpl        # * readme.md 主模板文件
└── support-tags.md      # 应用tag只是说明

```

#### 3.1 根据参数生成镜像Tag文档

根据代码Tag生成镜像tag的Markdown文档：

```bash
q-release-tag "0.12.9"
```

这条命令会更新镜像版本号是否已经在  `.template/release-tags.md` 文件中，如果不存在则新增，新增内容如下：

```markdown
* [`latest`, `0.12.9`](https://github.com/quicklyon/gogs-docker/blob/0.12.9/Dockerfile)
```

**注意：**

> 需要创建代码的tag版本号

#### 3.2 根据参数生成标签文档

前提：应用模板目录(.template)必须包含 `support-tags.md` 文件，如果没有则新建。

根据版本，URL信息生产标签的Markdown文档：

```bash
q-add-tag "0.12.9" "https://github.com/gogs/gogs/releases/tag/v0.12.9"
```

这条命令会检查添加的版本号是否已经在  `.template/suport-tags.md` 文件中，如果不存在则新增，新增内容如下：

```markdown
- [0.12.9](https://github.com/gogs/gogs/releases/tag/v0.12.9)
```

**注意：**

- 如果不存在  `.template/suport-tags.md` 文件，会新建，并添加如下内容：

```markdown
- [latest](https://github.com/gogs/gogs/tags/)
- [0.12.9](https://github.com/gogs/gogs/releases/tag/v0.12.9)
```

#### 3.3 根据模板渲染readme.md文件

渲染readme.md文件，打印到标准输出

```bash
# 标准输出预览
q-render-readme -v

# 直接覆盖当前目录下的README.md文件
q-render-readme
```

**说明：**

- 执行上面的命令后，会根据应用源码根目录的模板文件生成Markdown格式的readme.md文档，打印到标准输出。

## 三、Chart包维护

### 为Chart包添加changelog信息

```bash
cd charts

q-add-changelog <应用名称> <维护人>

# 示例
q-add-changelog 2fauth zhouyq

```

### 发布应用

```bash
cd charts
q-release-app <channel-name> <app-name>
```

> 注意：
>
> - channel-name: `test` 或 `stable`
