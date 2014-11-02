#!/bin/bash

dir=$(dirname $0)

cat $dir/$1 | while read line 
do
  time=$(date +%Y%m%d%H%M%H).$$

  echo $line
  syousetu_id=$(echo $line | awk -F"/" '{print $(NF-1)}')
  echo $syousetu_id
  curl $line > $dir/tmp/$syousetu_id.index
  
  num=$(cat $dir/tmp/$syousetu_id.index |
  grep "$syousetu_id" | 
  grep subtitle | 
  awk -F "/" '{print $3}' | 
  tail -n 1)

  for index in `seq 1 $num`
  do
    curl $line$index/ > $dir/tmp/$syousetu_id.$index.html
    sleep 1
  done
done
