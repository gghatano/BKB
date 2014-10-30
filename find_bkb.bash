#!/bin/bash

dir=$(dirname $0)

cat $1 | while read line
do
  echo $line | $dir/bkb_judge.bash
done
