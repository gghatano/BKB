#!/bin/bash

## 見つけたBKBを集めます. 
## bkb.tweet/tweetの各ファイルに, BKB1セットを入れます.

dir=$(dirname $0)

## ./bkb.tweet/bkb.txtにまとめます

[ -e "$dir/bkb.tweet/bkb.txt" ] && rm $dir/bkb.tweet/bkb.txt
touch $dir/bkb.tweet/bkb.txt
for time in `ls $dir/bkb.tweet | grep -v -E  ".txt$"`
do
  for file in `ls $dir/bkb.tweet/$time`
  do
    cat $dir/bkb.tweet/$time/$file >> $dir/bkb.tweet/bkb.txt
  done
done

time_now=$(date +%Y%m%d%H%M%S)

## 繧ｴ繝滓祉髯､
rm $dir/bkb.tweet/tweet/*

cat $dir/bkb.tweet/bkb.txt | grep -v -E "^\s*$" | awk -v OFS=":" '{print int((NR+3)/4), $0}' | while read line 
do
  tweet_id=$(echo $line | cut -d":" -f 1)
  echo $line | cut -d":" -f 2 >> $dir/bkb.tweet/tweet/$time_now.$tweet_id.txt
done

rm $dir/bkb.tweet/bkb.txt

