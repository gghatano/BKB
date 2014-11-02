#!/bin/bash

dir=$(dirname $0)

file_num=$(ls $dir/bkb.tweet/tweet | wc -l)
echo $file_num

set +e

## ひたすらツイート
while true ; do
  random=$(echo $((RANDOM / $file_num + 1)))
  tweet_file=$(ls $dir/bkb.tweet/tweet | awk -v random=$random '{if(NR==random) print $0}')
  tweet_contents=$(cat $dir/bkb.tweet/tweet/$tweet_file | tr '\n' ':')
  cat ~/bkb_tweet.R | sed "s/test/$tweet_contents/" | 
  tr ':' '\n' > ~/bkb_tweet.R.test
  R -f ~/bkb_tweet.R.test
  sleep 10
done
