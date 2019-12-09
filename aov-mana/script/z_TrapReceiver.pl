#!/usr/bin/perl

#################################################
#### ZABBIX SNMP TRAP RECEIVER CONFIGURATION ####
#################################################

### Option: SNMPTrapperFile
#	Temporary file used for passing data to the server (or proxy). Must be the same
#	as in the server (or proxy) configuration file.
#
# Mandatory: yes
# Default:
#$SNMPTrapperFile = '/tmp/zabbix_traps.tmp';
$SNMPTrapperFile = '/var/log/snmp/z_snmptrap.log';

### Option: DateTimeFormat
#	The date time format in strftime() format. Please make sure to have a corresponding
#	log time format for the SNMP trap items.
#
# Mandatory: yes
# Default:
$DateTimeFormat = '%H:%M:%S %Y/%m/%d';

###################################
#### ZABBIX SNMP TRAP RECEIVER ####
###################################

use Fcntl qw(O_WRONLY O_APPEND O_CREAT);
use POSIX qw(strftime);

sub zabbix_receiver
{
	my (%pdu_info) = %{$_[0]};
	my (@varbinds) = @{$_[1]};

	# open the output file
	unless (sysopen(OUTPUT_FILE, $SNMPTrapperFile, O_WRONLY|O_APPEND|O_CREAT, 0666))
	{
		print STDERR "Cannot open [$SNMPTrapperFile]: $!\n";
		return NETSNMPTRAPD_HANDLER_FAIL;
	}

	# get the host name
	my $hostname = $pdu_info{'receivedfrom'} || 'unknown';
	if ($hostname ne 'unknown')
	{
		$hostname =~ /\[(.*?)\].*/;                    # format: "UDP: [127.0.0.1]:41070->[127.0.0.1]"
		$hostname = $1 || 'unknown';
	}

	# print trap header
	#       timestamp must be placed at the beggining of the first line (can be omitted)
	#       the first line must include the header "ZBXTRAP [IP/DNS address] "
	#              * IP/DNS address is the used to find the corresponding SNMP trap items
	#              * this header will be cut during processing (will not appear in the item value)
	printf OUTPUT_FILE "%s ZBXTRAP %s\n", strftime($DateTimeFormat, localtime), $hostname;

	# print the PDU info
	print OUTPUT_FILE "PDU INFO:\n";
	foreach my $key(keys(%pdu_info))
	{
		if ($pdu_info{$key} !~ /^[[:print:]]*$/)
		{
			my $OctetAsHex = unpack('H*', $pdu_info{$key});	# convert octet string to hex
			$pdu_info{$key} = "0x$OctetAsHex";		# apply 0x prefix for consistency
		}

		printf OUTPUT_FILE "  %-30s %s\n", $key, $pdu_info{$key};
	}

	# print the variable bindings:
	print OUTPUT_FILE "VARBINDS:\n";
	foreach my $x (@varbinds)
	{
		#printf OUTPUT_FILE "  %-30s type=%-2d value=%s\n", $x->[0], $x->[2], $x->[1];
		
		my $value = $x->[1];
		if( $value =~ s/^Hex-STRING: //) {
			$value =~ s/(\n|\r|\r\n)//g;
			$value =~ s/(..) /chr(hex($1))/ge;
			$value = "Hex-STRING: " . $value;
		}
		printf OUTPUT_FILE "  %-30s type=%-2d value=%s\n", $x->[0], $x->[2], $value;

	}

	close (OUTPUT_FILE);

	return NETSNMPTRAPD_HANDLER_OK;
}

NetSNMP::TrapReceiver::register("all", \&zabbix_receiver) or
	die "failed to register Zabbix SNMP trap receiver\n";

print STDOUT "Loaded Zabbix SNMP trap receiver\n";
