#!/bin/bash

if [ ! -d "./mongo_items" ]
then
  echo "mongo_items directory missing"
  exit 1
fi

for i in `find mongo_items -mindepth 2 -maxdepth 2 -type d`
do
  d=`echo ${i} | cut -d"/" -f2`
  c=`echo ${i} | cut -d"/" -f3`
  for f in `find ${i} -maxdepth 1 -type f`
  do
    ./mongo-insert-doc.sh -d $d -c $c -i $f
  done
done