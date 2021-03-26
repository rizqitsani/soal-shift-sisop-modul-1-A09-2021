#!/bin/bash

# 1. A
regex='(?<=ERROR )(.*)(?= )'
regex2='(?<=\().+?(?=\))'

# 1. B
error_message() {
	grep -oP "$regex" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv
}

# 1. C
user_statistic() {
	grep -oP "$regex2" syslog.log | sort | uniq | while read i 
	do
		echo "$i" | tr '\n' ','
		grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','
		grep "$i" syslog.log | grep "ERROR" | wc -l 
	done >> user_statistic.csv
}

# 1. D
echo "Error, Count" > error_message.csv
error_message

# 1. F
echo "Username,INFO,ERROR" > user_statistic.csv
user_statistic
