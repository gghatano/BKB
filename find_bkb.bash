#!/bin/bash

dir=$(dirname $0)

file=$1
echo $file
echo "START WORD"
time=$(date +%Y%m%d%H%M%S)
mkdir $dir/bkb/$time
echo $time

cat $file | while read line
do
  filename=$(basename $file .html)
  echo $filename
  echo $line | $dir/text_process.bash |
  $dir/bkb_judge_word.bash >> $dir/bkb/$time/bkb_word.txt.$filename
done

echo "START CLAUSE"
echo $file
cat $file | while read line
do
  filename=$(basename $file .html)
  echo $filename
  echo $line | $dir/text_process.bash |
  $dir/bkb_judge_clause.bash >> $dir/bkb/$time/bkb_clause.txt.$filename
done

rm $dir/tmp/*

## ゴミ掃除


