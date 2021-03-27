#!/bin/bash

yesterday=$(date --date="yesterday" "+%d-%m-%Y")
today=$(date "+%d-%m-%Y")

item="bunny"
new_folder_name="Kelinci_$today"

if [ -d "Kucing_$yesterday" ]
then
  item="bunny"
  new_folder_name="Kelinci_$today"
else
  item="kitten"
  new_folder_name="Kucing_$today"
fi

for ((i=1; i<=23; i=i+1))
do
  wget -a Foto.log -nv "https://loremflickr.com/320/240/$item"
done

find . -type f -exec md5sum {} \; | sort | awk '
  BEGIN{lastHash = ""}
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

mkdir $new_folder_name

mv Koleksi_* $new_folder_name
mv Foto.log $new_folder_name
