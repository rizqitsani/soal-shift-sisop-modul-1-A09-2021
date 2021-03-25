#!/bin/bash

regex='(ERROR|INFO)(.*)' # Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log
regex2='(?<=ERROR )(.*)(?= )' # Mendapatkan log msg

# 1.A
# grep -oP '$regex' syslog.log

# 1.B

# echo "Error, Count" > error_message.csv
# grep -oP "$regex2" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv

# 1.C

# 1.D

# 1.E
