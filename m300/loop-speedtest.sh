#!/bin/bash
#
# 2020/10/16, borchen
#
# ./loop-speedtest.sh $device_ip 100 $log-loop-speedtest
#

device_ip=$1
loop_times=$2
log=$3

report_date=`date "+%Y%m%d%H%M"`

log=$log"-"$loop_times"-"$report_date
log_1="$log.log"
log_tag="./xxx/$log"

success_log="./xxx/success_upgrade.xxx"
fail_log="./xxx/fail_upgrade.xxx"
confirm_log="./xxx/confirm_flag.xxxxx"

echo $report_date > ./xxx/report_date.xxx

echo $log > ./xxx/log_file_name.xxxx

echo 0 | tee $success_log | tee $confirm_log > $fail_log

PID=`ps -eaf | grep $0 | grep -v grep | awk '{print $2}'`
echo $PID > ./xxx/now_PID.xxx

remote_ip="www.google.com"

reboot_num=0
for i in $(seq 1 $loop_times)
do

    echo ",,$i times loop, test speedtest Start Time: `date +%F-%H:%M:%S`" | tee -a $log_1

    ping -4 $remote_ip -c 10
    ./speedtest.sh
#    cat ./xxx/speedtest.xxxxx >> $log_1

    if [ -s ./xxx/speeddownload.xxxxx ]; then
        download=`cat ./xxx/speeddownload.xxxxx`
    fi
    if [ -s ./xxx/speedupload.xxxxx ]; then
        upload=`cat ./xxx/speedupload.xxxxx`
    fi
    sleep 1

    rm -rf ./xxx/speeddownload.xxxxx ./xxx/speedupload.xxxxx

    if [ `cat $confirm_log` == 1 ]; then

	echo $i", fail, speed test(speedtest.net) download=$download, upload=$upload" | tee -a $log_1

	if [ "$reboot_num" -le 3 ]; then	# <= 3

	  # log export
	  ./function/log-export.func $device_ip $i $log

	  sleep 2
	  down_name=`echo $0 | sed 's/.\///g' | awk -F"." '{print $1}'`
	  mkdir -p ./xxx/$down_name
	  mkdir -p $log_tag

	  # tar result
	  log_date=`cat ./xxx/log-export-log-date.xxxx`
	  cp ./xxx/log-export-$log_date.tar.gz ./xxx/$down_name
	  cp ./xxx/$backupfile ./xxx/$down_name
	  tar czvf ./xxx/$down_name-link-down-N$i-$log_date.tar.gz ./xxx/$down_name
	  mv ./xxx/$down_name-link-down-N$i-$log_date.tar.gz $log_tag
	  echo $i", tar web log, log export, backup file and all json file ($down_name-link-down-N$i-$log_date.tar.gz)" | tee -a $log_1
	  sleep 1
	  rm -rf ./xxx/$down_name

	fi
	reboot_flag=1
	echo 1 > $confirm_log
    else
	reboot_flag=0
	echo $i", pass, speed test(speedtest.net) download=$download, upload=$upload" | tee -a $log_1
    fi
    ./function/success_fail.func

#    echo ",,$i times End Time: `date +%F-%H:%M:%S`" | tee -a $log_1

    if [ "$reboot_flag" == 1 ]; then
	reboot_num=$[$reboot_num+1]
	./function/reboot.func $device_ip | tee -a $log_1
	echo $i", Rebooting, wait 200 seconds for reboot!!" | tee -a $log_1
	sleep 200
    fi


done

success=`cat $success_log`
fail=`cat $fail_log`

echo "" | tee -a $log_1
echo "" | tee -a $log_1
echo "Success:$success, Fail:$fail" | tee -a $log_1
echo "" | tee -a $log_1
echo "Test $[$success+$fail] times, Success, $success, Fail, $fail" | tee -a $log_1
