#!/bin/bash

MAX=50
yum update -y sssd sssd-common
systemctl restart sssd
find / -name 'sssd.mo' >> /var/log/fix_ipa.log

# ensure it keeps working for a while
for i in $(seq $MAX); do
    /usr/bin/sss_ssh_authorizedkeys jenkins-sfo01
    RET=$?
    if [ $RET != 0 ]; then
        systemctl restart sssd
        echo "$(date) sss_ssh_authorizedkeys not working, sssd restarted" >> /var/log/fix_ipa.log
    fi
    sleep 10
done
