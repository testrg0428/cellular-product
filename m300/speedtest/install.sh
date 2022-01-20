#!/bin/bash
#
# 2019/8/17, 2020/11/12 borchen
#
#

sudo apt update
sudo apt install -y screen expect curl
wget https://install.speedtest.net/app/cli/ookla-speedtest-1.0.0-armhf-linux.tgz
tar xzvf ookla-speedtest-1.0.0-armhf-linux.tgz
