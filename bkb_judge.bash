#!/bin/bash

cat ./test.txt.processed.head |
awk '{if(NR>1) print $0}' > test.txt.processed.head.second
cat ./test.txt.processed.head |
awk '{if(NR>2) print $0}' > test.txt.processed.head.third

paste ./test.txt.processed.head ./test.txt.processed.head.second ./test.txt.processed.head.third > hoge.txt
