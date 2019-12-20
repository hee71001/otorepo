#!/bin/perl
$max=125;
$split=3;

$| = 1;
$ps=int($max/$split+1);
for (1..$split){
print "0% [","#" x $_," " x ($split-$_),"] 100%";
print "\r";
sleep 1;
if ($_==$split){
print "[","=" x $split,"]\n";
exit;
}

}
