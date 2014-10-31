#!/bin/bash

set -e 

for file in `ls ~/works/aozora_scrape/sakaguchi_ango/processed_text`
do
  ./find_bkb.bash ~/works/aozora_scrape/sakaguchi_ango/processed_text/$file
done
