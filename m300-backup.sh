#!/bin/bash
#
# 2019/6/25, borchen
#
# m300-backup.sh
#
#

tmp=$1

rm -rf ./m300/xxx/log-export* ./m300/GPS*

if [ z"$tmp" == z ]; then
    report_date=`date "+%Y%m%d"`
    tar czvf m300-$report_date.tar.gz --exclude=firmware/*.img --exclude=m300/nohup.out m300 common firmware base-func *.sh
    echo "cp ./m300-$report_date.tar.gz to home"
    cp ./m300-$report_date.tar.gz ~
else
    report_date=`date "+%Y%m%d%H%M"`
    tar czvf m300-$tmp-$report_date.tar.gz --exclude=firmware/*.img --exclude=m300/nohup.out m300 common firmware base-func *.sh
fi
