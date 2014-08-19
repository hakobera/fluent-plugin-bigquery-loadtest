#!/bin/sh

for i in `seq 1 9`
do
  bq rm -f fluentd_test.access${i}
  bq mk -t fluentd_test.access${i} id:integer,time:TIMESTAMP,level:STRING,method:STRING,uri:STRING,reqtime:FLOAT
done
