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
ldir="/manager/script/s_log"
kinou=`date +"%Y%m%d" --date "1 day ago"`
kinou_nen=`date +"%Y" --date "1 day ago"`
kinou_tuki=`date +"%m" --date "1 day ago"`
kinou_hi=`date +"%d" --date "1 day ago"`

###########
# Program #
###########

echo ${kinou} > ${ldir}/test.log
echo kinou_pflogsumm_report.pl Start >> ${ldir}/backup.log
echo ### pflogsumm (yestaday) 統計 >> ### ${ldir}/backup.log
echo /manager/script/kinou_pflogsumm_report.pl ${kinou_tuki} ${kinou_hi}  >> ${ldir}/backup.log
/manager/script/kinou_pflogsumm_report.pl
#/manager/script/pflogsumm_report.pl 10
sleep 1
echo kinou_pflogsumm_report.pl END >> ${ldir}/backup.log


echo ### AOV-Mail 統計 ### >> ${ldir}/backup.log
echo caku.cgi Start >> t${ldir}/backup.log
cd /var/www/cgi-bin/MAIL/
./caku.cgi >  /var/www/utm_kanri/AOVMAIL/pflogsumm_report.html
sleep 1
echo caku.cgi END !! >> ${ldir}/backup.log



echo ### AOV-Mail awstats ### >> ${ldir}/backup.log
echo awstats Start >> ${ldir}/backup.log
/usr/share/awstats/wwwroot/cgi-bin/awstats.pl -config=mail -update
sleep 1
echo awstats END >> ${ldir}/backup.log


echo ### AQS-NTP01 Backup ### >> ${ldir}/backup.log
echo Backup Start >> ${ldir}/backup.log
${pdir}/aqs-ntp01_backup.sh
echo Backup END >> ${ldir}/backup.log



