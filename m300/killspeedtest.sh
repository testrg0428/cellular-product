#!/bin/bash
#
# 2019/8/17, 2020/11/12 borchen
#
#

pid_flag=$1
delay_time=$2

if [ z"$delay_time" == z ]; then delay_time=60; fi

echo "wait $delay_time seconds and then kill speedtest #$pid_flag"
sleep $delay_time

kill -9 $pid_flag

