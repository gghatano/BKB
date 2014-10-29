#!/bin/bash

pid=$$

## 単語分割

cat $1 | 
head -n 1 | 
mecab | 
awk -F "," '{print $1, $8}' | 
awk '{if(NF>1) print $1}' > test.txt.processed.word.$pid


## 先頭文字アルファベット
cat $1 | 
head -n 1 | 
mecab | 
awk -F "," '{print $1, $8}' | 
awk '{print $3}' | 
nkf -e | 
kakasi -Ka | 
cut -c 1 > test.txt.processed.head.$pid

## BKB探索
cat ./test.txt.processed.head.$pid |
awk '{if(NR>1) print $0}' > test.txt.processed.head.second.$pid
cat ./test.txt.processed.head.$pid |
awk '{if(NR>2) print $0}' > test.txt.processed.head.third.$pid


paste -d" " ./test.txt.processed.head.$pid ./test.txt.processed.head.second.$pid ./test.txt.processed.head.third.$pid > bkb_judge.txt.$pid

## BKBの場所
num=$(cat bkb_judge.txt.$pid | 
grep -n "b k b" | 
awk -F":" '{print $1}' | 
head -n 1)

## BKBを出力
cat test.txt.processed.word.$pid | 
awk -v num=$num '{if(NR>=num && NR <= num+2) print $0}' | 
tr -d "\n"

ls | grep $pid | xargs rm
