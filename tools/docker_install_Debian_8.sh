#!/bin/bash
# aliyun debian 8
apt-get update && apt-get upgrade
apt-get install -y apt-transport-https curl vim
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
sed -i "s@^ExecStart=*@ExecStart=/usr/bin/dockerd --registry-mirror=https://jigxceev.mirror.aliyuncs.com@" /etc/systemd/system/multi-user.target.wants/docker.service
systemctl daemon-reload && systemctl restart docker