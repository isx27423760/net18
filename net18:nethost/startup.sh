#! /bin/bash
# @edt ASIX M06 2018-2019
# crear i engegar host client
#--------------------------------------

/opt/docker/install.sh && echo "Install OK"
/usr/sbin/httpd
/usr/sbin/xinetd -dontfork && echo "Xinetd OK"
#/usr/sbin/sshd -D 

