#!/bin/bash

total=0
echo "Error,Count"

if [[ $(cat syslog.log) =~ 'The ticket was modified while updating' ]]; then
	echo "The ticket was modified while updating, ${total}"
fi

if [[ $(cat syslog.log) =~ 'Permission denied while closing ticket' ]]; then
	echo "Permission denied while closing ticket, ${total}"
fi

if [[ $(cat syslog.log) =~ 'Tried to add information to closed ticket' ]]; then
	echo "Tried to add information to closed ticket, ${total}"
fi

if [[ $(cat syslog.log) =~ "Ticket doesn't exist" ]]; then
	echo "Ticket doesn't exist, ${total}"
fi

if [[ $(cat syslog.log) =~ "Connection to DB failed" ]]; then
	echo "Connection to DB failed, ${total}"
fi

# Masih banyak yang belum selesai tapi kurang lebih mungkin begini
# Kurang count tiap error log, sorting, dan outputnya ke csv
