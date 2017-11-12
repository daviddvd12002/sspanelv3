# ss-panel

Let's talk about cat.  Based on [LightFish](https://github.com/Pongtan/LightFish).

[Donation](https://github.com/orvice/ss-panel/wiki/Donation)

[安装文档](https://sspanel.xyz/docs)

[![Build Status](https://travis-ci.org/orvice/ss-panel.svg?branch=master)](https://travis-ci.org/orvice/ss-panel) [![Coverage Status](https://coveralls.io/repos/github/orvice/ss-panel/badge.svg?branch=master)](https://coveralls.io/github/orvice/ss-panel?branch=master) [![Join the chat at https://gitter.im/orvice/ss-panel](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/orvice/ss-panel?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## About

Please visit [releases pages](https://github.com/orvice/ss-panel/releases) to download ss-panel.

## Requirements

* PHP 5.6 or newer
* Web server with URL rewriting
* MySQL

## Supported Server

* [shadowsocks manyuser](https://github.com/mengskysama/shadowsocks/tree/manyuser)
* [shadowsocks-go mu](https://github.com/catpie/ss-go-mu)
* [shadowsocksR](https://github.com/shadowsocksr/shadowsocksr)


## Install

### Step 0

```
git clone https://github.com/orvice/ss-panel.git
```

### Step 1

```
$ curl -sS https://getcomposer.org/installer | php
$ php composer.phar  install
```

### Step 2

```
cp .env.example .env
```

then edit .env

```
chmod -R 777 storage
```

### Step 3

Import the sql to you mysql database.

### Step 4

Nginx Config example:

if you download ss-panel on path /home/www/ss-panel


```
root /home/www/ss-panel/public;

location / {
    try_files $uri $uri/ /index.php$is_args$args;
}
    
```

### Step 5 Config

view config guide on [wiki](https://github.com/orvice/ss-panel/wiki/v3-Config)

### 500的解决办法：
主要有两种解决方案：

直接注释掉fastcgi.conf文件中的fastcgi_param PHP_ADMIN_VALUE "open_basedir=$document_root/:/tmp/:/proc/";这一行，一棒子打死了目录访问安全策略

在fastcgi.conf文件中，修改fastcgi_param PHP_ADMIN_VALUE "open_basedir=$document_root/:/tmp/:/proc/";，以test.com为例（此域名为添加vhost时输入的域名），修改内容如下：（这样做的坏处时每次添加vhost时都需要手动添加⊙﹏⊙）
/usr/local/nginx/conf/fastcgi.conf
fastcgi_param PHP_ADMIN_VALUE "open_basedir=/home/wwwroot/test.com/:/tmp/:/proc/";

### 数据库
node-> type=1 free node, type=2 pro node;
user-> plan=A free user, plan=B pro user;

