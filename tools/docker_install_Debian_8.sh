#!/bin/bash
# aliyun debian 8
apt-get update
apt-get install -y apt-transport-https curl vim
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
Ali_Mirror="--registry-mirror=https://jigxceev.mirror.aliyuncs.com"
sed -i "s@^ExecStart=/usr/bin/dockerd.*@ExecStart=/usr/bin/dockerd $Ali_Mirror@" /etc/systemd/system/multi-user.target.wants/docker.service
systemctl daemon-reload && systemctl restart docker