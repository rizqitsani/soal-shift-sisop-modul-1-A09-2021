#!/bin/bash

for ((i=1; i<=23; i=i+1))
do
  wget -a Foto.log -nv https://loremflickr.com/320/240/kitten
done

find . -type f -exec md5sum {} \; | sort | awk '
  BEGIN{last_hash = ""}
  {
    if($1 == last_hash) {
      print $2
    }
    last_hash = $1
  }
' | xargs rm

order=1
for pathname in $( find . -type f -name "kitten*" );
do
  if [ $order -lt 10 ]
  then
    mv $pathname "Koleksi_0$order"
  else
    mv $pathname "Koleksi_$order"
  fi
  let order=$order+1
done
