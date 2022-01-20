#!/bin/bash
#
# 2019/8/17, 2020/11/12 borchen
#
#

confirm_log="./xxx/confirm_flag.xxxxx"

PID=`ps -eaf | grep $0 | grep -v grep | awk '{print $2}'`
echo $PID > ./xxx/now_sub_PID.xxx

rm -rf ./xxx/speedtest.xxxxx

#   Speedtest by Ookla
#     Server: Homeplus - Shulin District (id = 29283)
#        ISP: Chunghwa Telecom
#    Latency:    21.01 ms   (240.30 ms jitter)
#   Download:    73.53 Mbps (data used: 69.3 MB)                               
#     Upload:     1.57 Mbps (data used: 2.0 MB)                               
#Packet Loss:     0.0%
# Result URL: https://www.speedtest.net/result/c/52b8b23f-4d9a-4c25-8170-edf7d9c1e105

./speedtest --accept-license > ./xxx/speedtest.xxxxx
sleep 1

download=`cat ./xxx/speedtest.xxxxx | grep Download | awk -F":" '{print $2}' | awk -F"Mbps" '{print $1}' | sed 's/ //g'`
upload=`cat ./xxx/speedtest.xxxxx | grep Upload | awk -F":" '{print $2}' | awk -F"Mbps" '{print $1}' | sed 's/ //g'`

if [ "$download" == "0.00" ]; then echo 1 > $confirm_log; fi
if [ "$upload" == "0.00" ]; then echo 1 > $confirm_log; fi

echo $download > ./xxx/speeddownload.xxxxx
echo $upload > ./xxx/speedupload.xxxxx

sleep 2

if [[ "" != "$PID" ]]; then
    echo "kill $PID"
    kill -9 $PID
fi
