#!/bin/perl

use strict;
use utf8;  #-ソースがUTF8だという宣言
use Time::HiRes 'sleep';
binmode STDOUT, ":utf8";  #-画面に出力したい文字コード
binmode STDERR, ":utf8";  #-エラー出力に使いたい文字コード
binmode STDIN, ":utf8";  #-標準入力から入ってくる文字コード
$| = 1;
for (0..10) {
	print "-";
	sleep(0.1);
	print "\r";
	print '\\';
	sleep(0.1);
	print "\r";
	print '|';
	sleep(0.1);
	print "\r";
	print '/';
	sleep(0.1);
	print "\r";
}
print "-\n";
exit;
