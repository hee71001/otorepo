#!/bin/sh
#####################################################
#
#       UTM Cacti
#       Oneday Scripts
#
#       Write   : otokata
#       Date    : 2017/04/11
#       UPDate  : 2017/04/11    
####################################################

#######
# ENV #
#######
pdir="/manager/script"
kinou=`date +"%Y%m%d" --date "1 day ago"`
kinou_nen=`date +"%Y" --date "1 day ago"`
kinou_tuki=`date +"%m" --date "1 day ago"`
kinou_hi=`date +"%d" --date "1 day ago"`

###########
# Program #
###########

echo /manager/script/manual_pflogsumm_report.pl ${kinou_tuki} ${kinou_hi} > /manager/script/test.log
/manager/script/manual_pflogsumm_report.pl ${kinou_tuki} ${kinou_hi}


