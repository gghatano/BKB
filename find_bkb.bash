#!/bin/bash

dir=$(dirname $0)

file=$1
echo $file
echo "START WORD"
cat $file | while read line
do
  filename=$(basename $file .html)
  echo $line | $dir/bkb_judge_word.bash >> $dir/bkb/$time/bkb_word.txt.$filename
done

echo "START CLAUSE"
echo $file
cat $file | while read line
do
  filename=$(basename $file .html)
  echo $line | $dir/bkb_judge_clause.bash >> $dir/bkb/bkb_clause.txt.$filename
done

## ゴミ掃除


