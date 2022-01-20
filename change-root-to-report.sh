#!/bin/bash
#
# 2021/8/10, borchen
#
# cp ./change-root-to-report.sh ~
#

product=$1
ver=$2


cd src/github/cellular-router/m300

log=`cat ./xxx/log_file_name.xxxx`

if [ z"$product" == z ] && [ z"$ver" == z ]; then
    product=`echo $log | awk -F"-" '{print $1}'`
    ver=`echo $log | awk -F"-" '{print $3}'`
fi

cd ../report/$product/$ver
exec bash

