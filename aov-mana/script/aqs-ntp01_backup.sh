#!/bin/sh
############################################################
#
#	AQS-NTP01 Bakup Program
#
#	Wirte	: oto
#	Data	: 2016/07/25
#	Update	: 2018/09/13
#
############################################################

###########
#   ENV   #
###########
User="root"
Pass="Neoaqs2013"
Today=`date '+%F'`
etc_A=("postfix" "vsftpd" "dovecot" "squid" "logrotate.d" )
etc_B=("aliases" "resolv.conf" "hosts" "passwd" "rsyslog.conf" "named.conf" "ntp.conf" "logrotate.conf")



###############
#   PROGRAM   #
###############

# =======================================#
#    Directory Create     
# =======================================#
cd /manager/backup
mkdir -p ${Today}
mkdir -p ${Today}\/etc
mkdir -p ${Today}\/var
chown -R oa105:oa105 ${Today}


# =======================================#
#    etc_A [ /etc/*** ] Directory_Backup
# =======================================#
cd /manager/backup/${Today}\/etc
for baka in ${etc_A[@]}
 do
	sshpass -p ${Pass} scp -o StrictHostKeyChecking=no -rp root@192.168.1.52:/etc/${baka}/ ./
 done
sleep 1

# =======================================#
#    etc_B [ /etc/*** ] File_Backup
# =======================================#
for aho in ${etc_B[@]}
 do
	sshpass -p ${Pass} scp -o StrictHostKeyChecking=no root@192.168.1.52:/etc/${aho} ./
 done

# =======================================#
#    Bind_Conf Backup
# =======================================#
cd /manager/backup/${Today}\/var
sshpass -p ${Pass} scp -o StrictHostKeyChecking=no -rp root@192.168.1.52:/var/named/ ./



# =======================================#
#    Compression [tar.gz]
# =======================================#
if [ -e /manager/backup/${Today} ]; then
    cd /manager/backup/
    tar -zcvf ${Today}.tar.gz ./${Today}
else
    echo Error Compression

fi

# =======================================#
#    Delete Directory
# =======================================#
if [ -e /manager/backup/${Today}.tar.gz ]; then
    rm -rf /manager/backup/${Today} 
else
    echo Error Delete_Directory
fi


