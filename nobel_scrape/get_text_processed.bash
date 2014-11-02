#!/bin/bash

dir=$(dirname $0)

## 整形した文章を作る. 
ls $dir/tmp | grep html | while read line 
do
   title=$(echo $line | awk -F"." '{print $1}')
   echo $title
   size=$(cat $dir/tmp/$line | wc -l)
   cat $dir/tmp/$line | 
   grep -A $size "novel_honbun" | 
   grep -B $size "novel_bn" |
   grep -v div | 
   sed 's/<[^>]*>//g' | 
   sed -e 's/\[[^]]*\]//g' -e 's/([^)]*)//g' | 
   sed -e 's/\s\s*//g' | 
   sed -e 's/（[^）]*）//g' -e 's/、/, /g' -e 's/「//g' -e 's/」//g' -e 's/・/ /g' -e 's/　//g' | 
   tr -d ',' | 
   tr '。' '\n' |  
   awk '{if(NF>0)print $0}' >> $dir/text/${title}.txt
done
