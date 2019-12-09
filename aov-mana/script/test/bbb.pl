#!/usr/bin/perl

use POSIX 'strftime';
####################################################
#
#       UTM FortiAnalyzer
#       ExternalDevice Backup
#
#       Write   : otokata
#       Date    : 2017/04/11
#       UPDate  : 2017/04/11    
####################################################

#######
# ENV #
#######
my $now = strftime "%Y/%m/%d %H:%M:%S", localtime;
my $kyou = strftime "%Y.%m.%d", localtime;
my $kinou = strftime('%Y.%m.%d' , localtime(time-60*60*24));
my $kinou2 = strftime('%Y%m%d' , localtime(time-60*60*24));
my $outfile = "/var/www/utm_kanri/AOVMAIL/LOG";
my $baka = $ARGV[0];

###########
# Program #
###########

open(OUT,"> $outfile/aovmail.$kinou.html"); 
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
<h3>$kinou </h3>
EOF

print "$kinou\n";
print "$kinou2\n";

#aov_maillog-20170411.gz  
open (IN, "zcat /var/log/rsyslog/aov_maillog-$kinou2.gz | pflogsumm -d yesterday --zero_fill --rej_add_from --verbose_msg_detail -e |") or die "$!";
 while (<IN>) {
	#print "$_<br>\n";
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


