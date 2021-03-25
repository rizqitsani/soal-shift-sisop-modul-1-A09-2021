#!/bin/bash

regex='(ERROR |INFO)(.*)'
regex2='(?<=ERROR )(.*)(?= )' # Regular expression untuk mendapatkan log msg
regex3='(?<=\().+?(?=\))' # Regular expression untuk mendapatkan username didalam ( )

# 1. A
# grep -oP "(ERROR |INFO)(.*)" syslog.log


# 1. B & E
echo "Error, Count" > error_message.csv
grep -oP "$regex2" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv


# 1. C & F
echo "Username,INFO,ERROR" > user_statistic.csv
grep -oP "$regex3" syslog.log | sort | uniq | while read i 
do
	echo "$i" | tr '\n' ','
	grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','
	grep "$i" syslog.log | grep "ERROR" | wc -l 
done >> user_statistic.csv
