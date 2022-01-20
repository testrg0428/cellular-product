#!/bin/bash
#
# 2019/8/17, 2020/11/12 borchen
#
#

loop_times=$1


if [ z"$loop_times" == z ] || [ "$loop_times" == "" ]; then loop_times=1; fi

#echo $loop_times

confirm_log="./xxx/confirm_flag.xxxxx"

PID=`ps -eaf | grep $0 | grep -v grep | awk '{print $2}'`
echo $PID > ./xxx/now_sub_PID.xxx

for i in $(seq 1 $loop_times)
do

#    echo $i
    rm -rf ./xxx/speedtest.xxxxx tee ./xxx/speeddownload.xxxxx ./xxx/speedupload.xxxxx

#   Speedtest by Ookla
#     Server: Homeplus - Shulin District (id = 29283)
#        ISP: Chunghwa Telecom
#    Latency:    21.01 ms   (240.30 ms jitter)
#   Download:    73.53 Mbps (data used: 69.3 MB)
#     Upload:     1.57 Mbps (data used: 2.0 MB)
#Packet Loss:     0.0%
# Result URL: https://www.speedtest.net/result/c/52b8b23f-4d9a-4c25-8170-edf7d9c1e105

    speedtest --accept-license | tee ./xxx/speedtest.xxxxx
    sleep 2

# OR use as below:

    for i in $(seq 1 5)
    do
        if [ ! -s ./xxx/speedtest.xxxxx ]; then
            curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - | tee ./xxx/speedtest.xxxxx
            sleep 1
            break
        fi
    done
# result:
#Retrieving speedtest.net configuration...
#Testing from FarEasTone (110.25.88.183)...
#Retrieving speedtest.net server list...
#Selecting best server based on ping...
#Hosted by Chunghwa Mobile (Taipei) [1.90 km]: 38.08 ms
#Testing download speed................................................................................
#Download: 33.57 Mbit/s
#Testing upload speed................................................................................................
#Upload: 2.60 Mbit/s


    sleep 1

    download=`cat ./xxx/speedtest.xxxxx | grep Download | awk -F":" '{print $2}' | awk -F"Mb" '{print $1}' | sed 's/ //g'`
    upload=`cat ./xxx/speedtest.xxxxx | grep Upload | awk -F":" '{print $2}' | awk -F"Mb" '{print $1}' | sed 's/ //g'`
    #sharejpg=`cat ./xxx/speedtest.xxxxx | grep "URL" | awk -F": " '{print $2}'`

    if [ z"$download" == z ] || [ "$download" == "0.00" ] || [ `echo $download | grep "0.0"` ]; then echo 1 > $confirm_log; fi
    if [ z"$upload" == z ] || [ "$upload" == "0.00" ] || [ `echo $upload | grep "0.0"` ]; then echo 1 > $confirm_log; fi

    sleep 1

    echo $download | tee ./xxx/speeddownload.xxxxx
    echo $upload | tee ./xxx/speedupload.xxxxx
    #echo $sharejpg | tee ./xxx/speedsharejpg.xxxxx

    sleep 1

done


./killspeedtest.sh $PID 10 &

if [[ "" != "$PID" ]]; then
    echo "kill $PID"
    kill -9 $PID
fi
