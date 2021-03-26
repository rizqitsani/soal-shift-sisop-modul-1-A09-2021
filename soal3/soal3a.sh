#!/bin/bash

for ((i=1; i<=23; i=i+1))
do
  wget -a Foto.log -nv https://loremflickr.com/320/240/kitten
done

md5sum * | sort | awk '
  BEGIN{lastHash = ""}
  {
    if($1 == last_hash) {
      print $2
    }
    last_hash = $1
  }
' | xargs rm

order=1
for file in *
do
  if [[ $file == *"kitten"* ]]
  then
    mv $file `printf "Koleksi_%02d" $order`
    let order=$order+1
  fi
done
