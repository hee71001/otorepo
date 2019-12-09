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
my $aho = $ARGV[1];
my $boke = "${baka}.${aho}";
my $bee = "${baka}${aho}";

###########
# Program #
###########

print "${boke}\n";
print "${bee}\n";


