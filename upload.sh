#!/bin/bash
#
# 2020/10/25, borchen
#
# ./upload.sh
#
# git branch --all
#
# git push origin abc   # add new branch abc to github
#

git add -A
git commit -m `date +%Y%m%d`
git push origin main
#git push --force origin main

