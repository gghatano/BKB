#!/bin/bash

pid=$$
dir=$(dirname $0)

## 単語分割
input=$(cat - )

echo $input | 
mecab | 
sed 's/*/.../g' | 
awk -F "," '{print $1, $8}' | 
awk '{if($3=="")print $1,$2,$1; else print $0}' | 
awk '{if(NF>=1) print $1}' > $dir/tmp/text.word.$pid


## 先頭文字アルファベットの出力
echo $input | 
head -n 1 | 
mecab | 
sed 's/*/.../g' | 
awk -F "," '{print $1, $8}' | 
awk '{if($3=="")print $1,$2,$1; else print $0}' | 
awk '{print $3}' | 
nkf -e | 
kakasi -Ka | 
cut -c 1 > $dir/tmp/text.head.$pid

## BKBの探索 先頭文字を1行ずつズラしてpaste
cat ./$dir/tmp/text.head.$pid |
awk '{if(NR>1) print $0}' > $dir/tmp/text.head.second.$pid
cat ./$dir/tmp/text.head.$pid |
awk '{if(NR>2) print $0}' > $dir/tmp/text.head.third.$pid

paste -d" " $dir/tmp/text.head.$pid $dir/tmp/text.head.second.$pid $dir/tmp/text.head.third.$pid > $dir/tmp/bkb_judge.txt.$pid

## BKBの場所: numで表す
num=$(cat $dir/tmp/bkb_judge.txt.$pid | 
grep -n "b k b" | 
awk -F":" '{print $1}' | 
head -n 1)

[ "$num" == "" ] && { echo "$pid NO BKB"; ls $dir/tmp | grep $pid | sed "s;^;$dir/tmp/;" | xargs rm ; exit 0; }

## BKBを出力: num, num+1, num+2の行
bkb=$(cat $dir/tmp/text.word.$pid | 
awk -v num=$num '{if(NR>=num && NR <= num+2) print $0}' | 
tr  "\n" " ")

echo $input
echo $bkb
echo "B! K! B!"
echo "ひぃーあ!"

## tmpの中のゴミを掃除
ls $dir/tmp | grep $pid | sed "s;^;$dir/tmp/;" | xargs rm

