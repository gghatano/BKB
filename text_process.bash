#!/bin/bash

cat - |
sed -e 's/\[[^]]*\]//g' -e 's/([^)]*)//g' | 
sed -e 's/\s\s*//g' | 
sed -e 's/（[^）]*）//g' -e 's/、/, /g' -e 's/[「」]/, /g'| 
tr -d ',' | 
tr '。' '\n' 

