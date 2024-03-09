#!/usr/bin/env bash
# idea taken from https://www.cyberciti.biz/faq/howto-move-migrate-user-accounts-old-to-new-server/
export UGIDLIMIT=1000
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/passwd > /var/tmp/passwd.mig
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/group > /var/tmp/group.mig
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534) {print $1}' /etc/passwd | tee - |egrep -f - /etc/shadow > /var/tmp/shadow.mig
cp /etc/gshadow /var/tmp/gshadow.mig
