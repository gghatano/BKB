#!/bin/bash

dir=$(dirname $0)
cat url_list | while read line 
do
  echo $line
  now_time=$(date +%Y%m%d%H%M%S).$$
  curl $line > $dir/tmp/$now_time
  num=$(cat $dir/tmp/$now_time | wc -l)
  cat $dir/tmp/$now_time | 
  grep -A $num "novel_honbun" | 
  grep -B $num "novel_bn" > $dir/tmp/$now_time.text
done
