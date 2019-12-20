#!/bin/sed -f
##
## Coloring STATUS of POSTFIX LOG
##
## Note: for DARK Background 
##
## Usage (Examples):
##
##   tail -f /var/log/maillog | ./colorize-postfix-status.sed
##
##   cat /var/log/maillog | ./colorize-postfix-status.sed | less -R
##
##

# Text attributes
# 0   All attributes off(reset)
# 1   Bold on
# 3   italic
# 4   Underscore (on monochrome display adapter only) 
# 5   Blink on
# 7   Reverse video on
# 8   Concealed on

# Foreground colors
# 30  Black
# 31  Red
# 32  Green
# 33  Yellow
# 34  Blue
# 35  Magenta
# 36  Cyan
# 37  White

# Background colors
# 40  Black
# 41  Red
# 42  Green
# 43  Yellow
# 44  Blue
# 45  Magenta
# 46  Cyan
# 47  White 



###############
#   Postfix   #
###############
s/\(status=sent\)/\x1b[1;34;46m\1\x1b[0m/
s/\(status=deferred\)/\x1b[1;37;42m\1\x1b[0m/
s/\(status=bounced\)/\x1b[1;30;43m\1\x1b[0m/
s/\(status=expired\)/\x1b[1;37;42m\1\x1b[0m/

#s/\(to=<[a-z]*@[a-z]*.*>,\)/\x1b[1;36;46m\1\x1b[0m/


#############
#   HTTPD   #
#############
s/\(HTTP\/1..\"\) \(2[0-9][0-9]\) /\1 \x1b[34m\2\x1b[0m /
s/\(HTTP\/1..\"\) \(3[0-9][0-9]\) /\1 \x1b[32m\2\x1b[0m /
s/\(HTTP\/1..\"\) \(4[0-9][0-9]\) /\1 \x1b[33m\2\x1b[0m /
s/\(HTTP\/1..\"\) \(5[0-9][0-9]\) /\1 \x1b[31m\2\x1b[0m /

###############
#   Postgre   #
###############
#s/\(info:\)/\x1b[1;36;44m\1\x1b[0m/
#s/\(notice:\)/\x1b[1;36;44m\1\x1b[0m/
s/\(WARN:\)/\x1b[1;37;42m\1\x1b[0m/
s/\(ERROR:\)/\x1b[1;30;43m\1\x1b[0m/

###########
#   EWS   #
###########
s/\(status='Email Delivered'\)/\x1b[1;36;44m\1\x1b[0m/
s/\(status='Email Deferred'\)/\x1b[1;37;42m\1\x1b[0m/
s/\(status='The undeliverable email has been bounced'\)/\x1b[1;30;43m\1\x1b[0m/




############
#   DNS    #
############
#ロギングのカテゴリ設定
#　general      以下のカテゴリに分類されない、その他全てのメッセージ
#　database     named の内部データベースに関するメッセージ。
#　security     要求の承認と拒否に関するメッセージ。
#　config       設定ファイルの処理に関するメッセージ。
#　resolver     名前解決に関するメッセージ。再帰的に問い合わせへの応答も含む。
#　xfer-in      他サーバーから自ホストへのゾーン転送に関するメッセージ。
#　xfer-out　   自ホストから他サーバーへのゾーン転送に関するメッセージ。
#　notify　     非同期びゾーン更新通知に関するメッセージ。
#　client　     クライアントからの要求に関するメッセージ。
#　unmatched    どのview にもマッチしなかったメッセージ。
#　network      ネットワークに関するメッセージ。
#　upadate　    動的更新に関するメッセージ。
#　queries      問い合わせのログ。
#　dnssec       DNSSECとTSIGの処理に関するメッセージ。
#　lame-servers         名前解決を試みようとして発

s/\(database:\)/\x1b[1;36;44m\1\x1b[0m/
s/\(security:\)/\x1b[1;36;43m\1\x1b[0m/
s/\(config:\)/\x1b[1;37;43m\1\x1b[0m/
s/\(resolver:\)/\x1b[1;37;42m\1\x1b[0m/
s/\(xfer-in:\)/\x1b[1;30;43m\1\x1b[0m/
s/\(xfer-out:\)/\x1b[1;30;43m\1\x1b[0m/
s/\(notify:\)/\x1b[1;38;42m\1\x1b[0m/
s/\(client:\)/\x1b[1;38;42m\1\x1b[0m/


###########
# Netapp  #
###########

#s/\(down\)/\x1b[1;36;44m\1\x1b[0m/
#s/\(Down\)/\x1b[1;36;44m\1\x1b[0m/
s/\(error\)/\x1b[1;36;43m\1\x1b[0m/
s/\(Error\)/\x1b[1;36;43m\1\x1b[0m/
s/\(warning\)/\x1b[1;37;43m\1\x1b[0m/
s/\(Warning\)/\x1b[1;37;43m\1\x1b[0m/
s/\(Failed\)/\x1b[1;37;42m\1\x1b[0m/
s/\(FAILED\)/\x1b[1;37;42m\1\x1b[0m/
s/\(failed\)/\x1b[1;38;42m\1\x1b[0m/
s/\(No\)/\x1b[1;37;42m\1\x1b[0m/
#s/\(no\)/\x1b[1;37;42m\1\x1b[0m/
#s/\(None\)/\x1b[1;38;42m\1\x1b[0m/
#s/\(none\)/\x1b[1;38;42m\1\x1b[0m/
s/\(Cannot\)/\x1b[1;37;42m\1\x1b[0m/
s/\(cannot\)/\x1b[1;37;42m\1\x1b[0m/
s/\(disconnect\)/\x1b[1;30;43m\1\x1b[0m/
s/\(Unable\)/\x1b[1;30;43m\1\x1b[0m/
s/\(unable\)/\x1b[1;30;43m\1\x1b[0m/
s/\(Not\)/\x1b[1;38;42m\1\x1b[0m/
s/\(not\)/\x1b[1;38;42m\1\x1b[0m/
s/\(denied\)/\x1b[1;38;42m\1\x1b[0m/
s/\(Missing\)/\x1b[1;38;42m\1\x1b[0m/
s/\(missing\)/\x1b[1;38;42m\1\x1b[0m/
s/\(doesn't exist\)/\x1b[1;38;42m\1\x1b[0m/
s/\(overwrite\)/\x1b[1;38;42m\1\x1b[0m/
s/\(Bad\)/\x1b[1;38;42m\1\x1b[0m/
s/\(not found\)/\x1b[1;38;42m\1\x1b[0m/

###########
# FortiOS #
###########
s/\(is down\)/\x1b[36;47;5m\1\x1b[0m/
s/\(is up\)/\x1b[36;47;5m\1\x1b[0m/
s/\(failed\)/\x1b[1;35;44m\1\x1b[0m/
s/\(Failed\)/\x1b[1;35;44m\1\x1b[0m/
s/\(warning\)/\x1b[1;39;44m\1\x1b[0m/
s/\(error\)/\x1b[1;33;43m\1\x1b[0m/
s/\(alert\)/\x1b[1;35;44m\1\x1b[0m/
#s/\(msg\)/\x1b[1;47m\1\x1b[0m/
#s/\(log_id\)/\x1b[1;46m\1\x1b[0m/
#s/\(serial\)/\x1b[1;26m\1\x1b[0m/
s/\(device_id\)/\x1b[1;33;48m\1\x1b[0m/
#s/\(device"\)/\x1b[1;36;44m\1\x1b[0m/

#######
# oto #
#######
#s/\($1\)/\x1b[36;47;5m\1\x1b[0m/
#s/\($2\)/\x1b[36;47;5m\1\x1b[0m/
#s/\($3\)/\x1b[1;35;44m\1\x1b[0m/
s/\(196\)/\x1b[36;47;5m\1\x1b[0m/