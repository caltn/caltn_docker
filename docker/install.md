# docker install
https://docs.docker.com/install/linux/docker-ce/ubuntu/

## 一、ubuntu
### 1、更新
```
apt-get update
apt-get upgrade
```
### 2、依赖
```
apt-get install -y libltdl7 libsystemd-journal0
apt-get install -y  libsystemd-journal0
```
### 3、安装docker(2.0版本)
到官网下载 deb文件  
https://download.docker.com/linux/ubuntu/dists/
或者其他方式安装

```
sudo chmod +x ./下面三个文件
sudo dpkg -i ./docker-ce-cli_18.09.0_3-0_ubuntu-xenial_amd64.deb
sudo dpkg -i ./containerd.io_1.2.0-1_amd64.deb
sudo dpkg -i  ./docker-ce_18.09.0_3-0_ubuntu-xenial_amd64.deb


//docker compose 
1、curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

2、chmod +x /usr/local/bin/docker-compose
```

## 二、屏幕
```
apt-get install screen
screen -S Docker
```