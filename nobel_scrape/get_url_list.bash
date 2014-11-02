#!/bin/bash

cat ./index.html | 
grep href | grep subtitle | 
awk -F"\"" '{print $4}' | 
sed 's;^;ncode.syosetu.com/;' > url_list

