#!/bin/bash

bash soal3a.sh

dir_name=$(date "+%d-%m-%Y")
mkdir $dir_name

mv Koleksi_* $dir_name
mv Foto.log $dir_name
