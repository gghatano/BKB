#!/bin/bash

set +e 

## 文書ファイルが入ったディレクトリを引数に.

corpus=$1
for file in `ls $corpus | grep -v text.txt `
do
  echo $file
  ./find_bkb.bash $corpus/$file
done

ls -ltr bkb | awk '{if($5==0) print $9}' | xargs rm
