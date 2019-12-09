#!/bin/sh
################################################
#
#       UTM Program
#       Last 90days Log Delete
#
#       Write   : otokata
#       Date    : 2014/06/13
#       UPDate  : 2014/06/13
################################################

# -u, ―atime : 最終アクセス時刻
# -m, ―mtime : 最終ファイル変更時刻
# -c, ―ctime : 最終inode変更時刻(パーミッション、所有者、グループ、または他のメタデータが変更された時刻)
# -M, ―dirmtime : 最終dir修正時刻
# -a, ―all :全てのファイルタイプを削除する。
# -d, ―nodirs : 空dirであってもdirを削除しない。
# -d, ―nosymlinks :symbolic link は削除しない
# -f, ―force : rootであっても削除する。
# -q, ―quiet : エラー時のみ、ログを出す。
# -s, ―fuser : ファイルを開いているか確認。
# -t, ―test :　test。実際には削除しない。
# -U, ―exclude-user=user : ここで指定したuserが所有しているファイルは削除対象外。
# -v, ―verbose : 詳細なログ表示。
# -x, ―exclude=path : ここで指定したパスは削除対象外。
# -X, ―exclude-pattern=pattern :ここで指定したパターンに一致すれば削除対象外。

###############
#   Program   #
###############

# 確認
#tmpwatch -tumcv 72 /var/log/

# 掃除
tmpwatch -umcv 90d /var/log/
tmpwatch -umcv 90d /var/log/rsyslog/
#tmpwatch -umcv 90d /var/log/vsftpd/

#tmpwatch -umv 31d /manager/backup
#test
tmpwatch -umv 7d /manager/backup
find /manager/backup -mtime +30 -exec rm -rf {} \;
