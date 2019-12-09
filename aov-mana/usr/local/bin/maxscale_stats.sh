#!/bin/bash
#
# convert output from "maxadmin -pmariadb list threads"
# in useful values to return with snmp
# v 1.0 circulosmeos, 201508 (http://wp.me/p2FmmK-8z)
#
# Polling Threads.
#
# Historic Thread Load Average: 1.03.
# Current Thread Load Average: 0.00.
# 15 Minute Average: 0.04, 5 Minute Average: 0.13, 1 Minute Average: 0.33
#
# Pending event queue length averages:
# 15 Minute Average: 0.00, 5 Minute Average: 0.00, 1 Minute Average: 0.00
#
#  ID | State      | # fds  | Descriptor       | Running  | Event
# ----+------------+--------+------------------+----------+---------------
#   0 | Polling    |        |                  |          |
#   1 | Polling    |        |                  |          |
#   2 | Polling    |        |                  |          |
#   3 | Processing |      1 | 0x8f2a08010bc0   | <  100ms | IN|OUT
#

# maxscale v 1.1 :
MAXSCALE_PATH='/usr/local/mariadb-maxscale'
MAXSCALE_PASSWORD='mariadb'

# maxscale v 1.0 :
#MAXSCALE_PATH='/usr/local/skysql/maxscale'
#MAXSCALE_PASSWORD='skysql'

# .................................................

OUTPUT="$($MAXSCALE_PATH/bin/maxadmin -p$MAXSCALE_PASSWORD list threads | tr -dc '[:alnum:] :.,\n\r')"

# averages:
# Thread Load Average
THREAD_LOAD_AVRG="$(    echo "${OUTPUT}" | grep -A 1 "Current Thread Load Average" | tail -1 | awk -F", " '{print $2;}' | awk -F": " '{print $2;}' )"
# Pending event queue length
PENDING_QUEUE_LENGTH="$(echo "${OUTPUT}" | grep -A 1 "Pending event queue length"  | tail -1 | awk -F", " '{print $2;}' | awk -F": " '{print $2;}' )"

# counts:
THREADS_TOTAL="$(echo "${OUTPUT}" |egrep "( Polling | Processing )" | wc -l )"
THREADS_POLLING="$(echo "${OUTPUT}" |egrep " Polling " | wc -l )"
THREADS_PROCESSING="$(echo "${OUTPUT}" |egrep " Processing " | wc -l )"

echo $THREAD_LOAD_AVRG
echo $PENDING_QUEUE_LENGTH
echo $THREADS_TOTAL
echo $THREADS_POLLING
echo $THREADS_PROCESSING
