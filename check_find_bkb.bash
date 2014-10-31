#!/bin/bash

set -e 

for file in `ls ~/works/aozora_scrape/person1403/text_processed `
do
  ./find_bkb.bash ~/works/aozora_scrape/person1403/text_processed/$file
done
