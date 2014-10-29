#!/bin/bash

cat sentence.txt|
 sed -e 's/\[[^]]*\]//g' -e 's/([^)]*)//g' -e 's/\s\s*//g' | 
 tr '。' '\n' | 
 sed 's/、//g'

