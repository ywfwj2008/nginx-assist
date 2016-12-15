#!/bin/bash
# aliyun debian 8
apt-get update
apt-get install -y apt-transport-https curl vim
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
Ali_Mirror="--registry-mirror=https://jigxceev.mirror.aliyuncs.com"
sed -i "s@^ExecStart=/usr/bin/dockerd.*@ExecStart=/usr/bin/dockerd -H fd:// $Ali_Mirror@" /lib/systemd/system/docker.service
systemctl daemon-reload && systemctl restart docker