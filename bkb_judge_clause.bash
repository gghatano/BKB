#!/bin/bash

## 標準入力に1文を流してください
## 文節で区切って, BKBを探します. 

dir=$(dirname $0)
pid=$$

input=$(cat - )

#echo $input

## 文節分割
echo $input | 
cabocha | 
awk -F "-" '{print $1}' | 
sed 's/^ *//g' | 
grep -v "^OS$" | 
grep -v "^EOS$" > $dir/tmp/clause.txt.$pid

## 文節先頭文字抽出からのローマ字変換
echo $input | 
cabocha | 
awk -F "-" '{print $1}' | 
gsed 's/^ *//g' | 
gsed '1s/^/先頭行\n/' | 
mecab | 
grep -A 1 "^EOS$" | 
grep -v "EOS" | 
grep -v "-" | 
awk -F "," '{print $8}' | 
cut -c 1 | 
nkf -e | 
kakasi -Ka | 
cut -c 1 > $dir/tmp/clause.head.txt.$pid

## BKB判定
cat $dir/tmp/clause.head.txt.$pid | 
awk '{if(NR>=2)print $0}' > $dir/tmp/clause.head.txt.${pid}.2

cat $dir/tmp/clause.head.txt.$pid | 
awk '{if(NR>=3)print $0}' > $dir/tmp/clause.head.txt.${pid}.3

paste -d " " $dir/tmp/clause.head.txt.$pid $dir/tmp/clause.head.txt.$pid.2 $dir/tmp/clause.head.txt.$pid.3 > $dir/tmp/bkb_clause.judge.txt.$pid

num=$(cat $dir/tmp/bkb_clause.judge.txt.$pid | 
grep -n "b k b" | 
awk -F":" '{print $1}')

## BKBがなかったら終了
[ "$num" == "" ] && { echo "$pid:NOBKB" ; ls $dir/tmp | grep "$pid" | sed "s;^;$dir/tmp/;" | xargs rm ; exit 0; }

## あったらBKB
echo $input
cat $dir/tmp/clause.txt.$pid | 
awk -v num=$num '{if(NR>=num && NR <= num+2) print $0}'|
tr "\n" " " | 
xargs echo
echo "B! K! B!"
echo "ひぃーあ!!"

## ゴミ掃除
ls $dir/tmp | grep "$pid" | sed "s;^;$dir/tmp/;" | xargs rm 
