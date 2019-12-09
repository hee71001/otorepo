#!/bin/sh
################################################
#
#       UTM Program
#       NTP Synchronism
#
#       Write   : otokata
#       Date    : 2014/06/13
#       UPDate  : 2014/06/13
################################################

###############
#   Program   #
###############
systemctl stop ntpd
/usr/sbin/ntpdate -b 219.96.65.52
systemctl start ntpd

