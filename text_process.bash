#!/bin/bash

cat - |
sed -e 's/\[[^]]*\]//g' -e 's/([^)]*)//g' | #カッコ内を削除
sed -e 's/\s\s*//g' | # 空白を削除
sed -e 's/[「」｛｝＜＞：；]/,/g' |
sed -e 's/、/, /g' -e 's/[「」]/, /g' -e 's/・/ /g' | 
tr -d ',' | 
tr '。' '\n' 

