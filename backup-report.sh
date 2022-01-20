#!/bin/bash
#
# 2019/6/25, borchen
#
# m300-backup.sh m330 v0.06
#
#

product=$1
ver=$2

report_date=`date "+%Y%m%d"`

if [ "$product" != "" ] && [ "$ver" != "" ]; then
    if [ -d ./report/$product ]; then
	if [ z"$ver" == z ]; then
            tar czvf $product-$ver-report-$report_date.tar.gz "./report/$product" backup-report.sh m300-backup.sh upload.sh download.sh untar_dir.sh tar_dir.sh
            echo "cp ./$product-report-$report_date.tar.gz to home"
            cp ./$product-report-$report_date.tar.gz ~
	else
            tar czvf $product-$ver-report-$report_date.tar.gz "./report/$product/$ver" backup-report.sh m300-backup.sh upload.sh download.sh untar_dir.sh tar_dir.sh
            echo "cp ./$product-$ver-report-$report_date.tar.gz to home"
            cp ./$product-$ver-report-$report_date.tar.gz ~
	fi
    fi
else
    if [ z"$product" != z ]; then
	tar czvf $product-report-$report_date.tar.gz ./report/$product backup-report.sh m300-backup.sh upload.sh download.sh untar_dir.sh tar_dir.sh
	echo "mv ./$product-report-$report_date.tar.gz to home"
	mv ./$product-report-$report_date.tar.gz ~
    fi
fi


