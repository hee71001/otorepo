#!/usr/bin/perl

####################################################
#
#       UTM FortiAnalyzer
#       ExternalDevice Backup
#
#       Write   : otokata
#       Date    : 2017/04/11
#       UPDate  : 2017/05/11    
####################################################

##########
# Module #
##########
use POSIX 'strftime';


#######
# ENV #
#######

### 昨日 ###
$yesterday = strftime('%Y%m%d' , localtime(time-60*60*24));		# 20170510
$kinou = strftime('%Y.%m.%d' , localtime(time-60*60*24));		# 2017.05.10


### 出力場所 ### 
$outfile = "/var/www/utm_kanri/AOVMAIL/LOG";
$rsyslogfile = "/var/log/rsyslog";

###########
# Program #
###########

open(OUT,"> ${outfile}/aovmail.${kinou}.html"); 
print OUT <<EOF;
<html>
<head>
<link rel="stylesheet" type="text/css" href="yyy.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>AQS-NTP01 Mail Report</title>
</head>
<body>
<h2>AQS-NTP01 Mail Report</h2>
<div class="section">
<div class="inner">
<h3>${kinou}</h3>
EOF


open (IN, "zcat ${rsyslogfile}/aov_maillog-${yesterday}.gz | /usr/sbin/pflogsumm -d yesterday --zero_fill --rej_add_from --verbose_msg_detail -e |") or die "$!";
 while (<IN>) {
	print "$_<br>\n";
	print (OUT "$_<br>\n");
}
close(IN); 



print OUT<<EOF;
  </div>
  </div>
  </body>
  </html>
EOF
close(OUT); 

