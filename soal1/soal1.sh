#!/bin/bash

regex2='(?<=ERROR )(.*)(?= )' # Regular Expression untuk mendapatkan log msg

# 1.B & D

echo "Error, Count" > error_message.csv
grep -oP "$regex2" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv
# 'grep -oP "$regex2" syslog.log' untuk menampilkan semua pesan log
# 'sort | uniq -c' disort kemudian dihitung perline untuk mendapatkan jumlah kemunculan tiap error
# 'sort -nr' Mensorting number kemudian di reverse karena butuh yang terbanyak ditaruh diatas
# sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' untuk menswap nomor yang awalnya berada didepan string menjadi dibelakang string dan diberi koma


# 1. C & F
