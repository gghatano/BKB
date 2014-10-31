#!/bin/bash

set -e 

corpus=$1
for file in `ls $corpus`
do
  ./find_bkb.bash $coupus/$file
done
