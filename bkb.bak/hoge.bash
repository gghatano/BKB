#!/bin/bash

cat ./bkb.txt.akutagawa | while read line
do
  num=$(echo $line | awk -F":" '{print $1}')
  char=$(echo $line | awk -F":" '{print $2}')
  echo $num
  echo $char >> tweet/$num.txt
done
