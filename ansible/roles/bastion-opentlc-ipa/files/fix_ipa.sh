#!/bin/bash

MAX=20

# ensure it keeps working for a while
for i in $(seq $MAX); do
    /usr/bin/sss_ssh_authorizedkeys jenkins-sfo01
    RET=$?
    if [ $RET != 0 ]; then
        systemctl restart sssd
    fi
    sleep 10
done
