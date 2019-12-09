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

#./manual_pflogsumm_report.pl 04 27


#######
# ENV #
#######
my $now = strftime "%Y/%m/%d %H:%M:%S", localtime;
my $kyou = strftime "%Y.%m.%d", localtime;
my $kinou = strftime('%Y.%m.%d' , localtime(time-60*60*24));
my $kinou2 = strftime('%Y%m%d' , localtime(time-60*60*24));
my $outfile = "/var/www/utm_kanri/AOVMAIL/LOG";
my $baka = $ARGV[0];
my $aho = $ARGV[1];
my $boke = "${baka}.${aho}";
my $bee = "${baka}${aho}";

###########
# Program #
###########

open(OUT,"> $outfile/aovmail.2017.${boke}.html"); 
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
<h3>2017.${boke} </h3>
EOF

open (IN, "zcat /var/log/rsyslog/aov_maillog-2017${bee}.gz| /usr/sbin/pflogsummp -d yesterday --zero_fill --rej_add_from --verbose_msg_detail -e |") or die "$!";
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

