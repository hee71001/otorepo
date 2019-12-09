#!/usr/bin/perl

$Mem = `sshpass -p A9stgMngd89 ssh -l admin 192.168.1.38 diagnose hardware info | ag "Active:" | awk '{print \$2}'`;

print $Mem;
