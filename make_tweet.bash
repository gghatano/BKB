#!/bin/bash

set +e
for num in `seq 65 5`
do
  tweet=$(cat ./bkb/tweet/${num}.txt | tr '\n' ':')

  cat ~/bkb_tweet.R |
  sed "s;test;$tweet;" |
  tr ':' '\n' > ~/bkb_tweet.R.test

  R -f ~/bkb_tweet.R.test

  sleep 30
done

