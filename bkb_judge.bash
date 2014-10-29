#!/bin/bash

## 単語分割
cat $1 | 
head -n 1 | 
mecab | 
awk -F "," '{print $1, $8}' | 
awk '{if(NF>1) print $1}' > test.txt.processed.word

## 先頭文字アルファベット
cat ./test.txt.processed | 
head -n 1 | 
mecab | 
awk -F "," '{print $1, $8}' | 
awk '{print $3}' | 
nkf -e | 
kakasi -Ka | 
cut -c 1 > test.txt.processed.head

## BKB探索
cat ./test.txt.processed.head |
awk '{if(NR>1) print $0}' > test.txt.processed.head.second
cat ./test.txt.processed.head |
awk '{if(NR>2) print $0}' > test.txt.processed.head.third

paste -d" " ./test.txt.processed.head ./test.txt.processed.head.second ./test.txt.processed.head.third > bkb_judge.txt

## BKBの場所
num=$(cat bkb_judge.txt | 
grep -n "b k b" | 
awk -F":" '{print $1}' | 
head -n 1)

## BKBを出力
cat test.txt.processed.word | 
awk -v num=$num '{if(NR>=num && NR <= num+2) print $0}' | 
tr -d "\n"
