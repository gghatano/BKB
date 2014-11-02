#!/bin/bash

## Œ©‚Â‚¯‚½BKB‚ðW‚ß‚Ü‚·. 

dir=$(dirname $0)

## ./bkb/bkb.txt‚É‚Ü‚Æ‚ß‚Ü‚·

[ -e "$dir/bkb/bkb.txt" ] && rm $dir/bkb/bkb.txt
touch $dir/bkb/bkb.txt
for time in `ls $dir/bkb | grep -v -E  ".txt$"`
do
  for file in `ls $dir/bkb/$time`
  do
    cat $dir/bkb/$time/$file >> $dir/bkb/bkb.txt
  done
done

time_now=$(date +%Y%m%d%H%M%S)

## ã‚´ãƒŸæŽƒé™¤
rm $dir/bkb/tweet/*

cat $dir/bkb/bkb.txt | grep -v -E "^\s*$" | awk -v OFS=":" '{print int((NR+3)/4), $0}' | while read line 
do
  tweet_id=$(echo $line | cut -d":" -f 1)
  echo $line | cut -d":" -f 2 >> $dir/bkb/tweet/$time_now.$tweet_id.txt
done

rm $dir/bkb/bkb.txt

