#!/bin/bash

#---------------------------------------------- #
#	SYSTEM					#
#---------------------------------------------- #
hostname=`hostname`;
id=`env LANG=C id`;
uptime=`env LANG=C uptime`;
date=`date "+%Y/%m/%d (%A) %H:%M:%S"`;
smtp_host=192.168.1.52;
smtp_port=25;


#---------------------------------------------- #
#	Messege 				#
#---------------------------------------------- #
mesg="Test Mail SQ-SIEM";
mesg1="SQ-SIEM shiken";
#mesg2="o(･ω･｡) ヽ(｡>ω<)ﾉ";

#mesg="date=2017-10-11 time=05:24:57 logver=52 itime=1507667098 devname=H003601G240DRA";
#mesg1="level=warning vd=root msg="File is infected." action=blocked service=SMTP ";


#---------------------------------------------- #
#	FROM 					#
#---------------------------------------------- #
#from_addr=aov105@oaas.ntt-neo.jp
#from_addr=oa105@oaas.ntt-neo.jp
from_addr=root@oaas.ntt-neo.jp

#from_addr=cotoha-support@oaas.ntt-neo.jp
#from_addr=gisc-support@sc.ntt-neo.jp
#from_addr=sdp-admin@sc.ntt-neo.jp
#from_addr=neo@oaas.ntt-neo.jp
#from_addr=isp-online-support@oaas.ntt-neo.jp
#from_addr=utm-support@oaas.ntt-neo.jp


#---------------------------------------------- #
#	TO 					#
#---------------------------------------------- #
#to_addr=sq-support@oaas.ntt-neo.jp

to_addr=aaaaaaaaayousuke.otokata.mh@west.ntt.co.jp
#to_addr=sdp-admin@sc.ntt-neo.jp
#to_addr=oto.hee71001@hotmail.co.jp
#to_addr=jichitaisc-unkan-neo@west.ntt.co.jp
#to_addr=utm-alert-neo@west.ntt.co.jp
#to_addr=utm-support@oaas.ntt-neo.jp
#aqstage-tier1-neo@west.ntt.co.jp

#---------------------------------------------- #
#	SUBJECT 				#
#---------------------------------------------- #
#subject="[TestMail SQ-SIEM] from AOV(aqs-ntp01) PID:$$";

subject="[TestMail ISPonline] from MX(isp-wafmgmt01) PID:$$";
#subject="[TestMail RSE] from ${hostname} PID:$$";
#subject="AntiVirus[SMTP] (high virus alert W32/Injector.DSJB!tr H003601G240DRA)";



#---------------------------------------------- #
#	PROGRAM 				#
#---------------------------------------------- #
send_host=mx.hogehoge.foo.bar;
echo "from:${from_addr}, to:${to_addr}";
(
echo EHLO ${send_host};                      sleep 1;
echo MAIL FROM: ${from_addr};                sleep 1;
echo RCPT TO: ${to_addr};                    sleep 1;
echo DATA;                                   sleep 1;
echo Subject: ${subject};                    sleep 1;
echo From: ${from_addr};                     sleep 1;
echo To: ${to_addr};                         sleep 1;
echo ;                                       sleep 1;
echo ;                                       sleep 1;
echo ${date};                                sleep 1;
echo ${mesg};                                sleep 1;
echo ${mesg1};                                sleep 1;
echo ${mesg2};                                sleep 1;
echo .;                                      sleep 1;
echo QUIT;                                   sleep 1;
) | telnet ${smtp_host} ${smtp_port};
exit 0;




