#!/bin/bash

dir=$(dirname $0)

file=$1
echo $file
echo "START WORD"
cat $file | while read line
do
  echo $line | $dir/bkb_judge_word.bash >> $dir/bkb/bkb_word.txt
done

echo "START CLAUSE"
echo $file
cat $file | while read line
do
  echo $line | $dir/bkb_judge_clause.bash >> $dir/bkb/bkb_clause.txt
done
