#!/bin/bash
# Initial (first) installation / configuration to CentOS
# Created by Yevgeniy Goncharov, https://sys-adm.in

# Envs
# ---------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

cd $SCRIPT_PATH

# ---------------------------------------------------\
# Remove unnecessary software 
yum erase iwl* -y

# Update & Install software 
yum update -y && yum install wget nano git net-tools epel-release -y

# ---------------------------------------------------\

echo -en "Disable SELinux (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
  sed -i 's/=enforcing/=permissive/' /etc/selinux/config
  echo "SELinux is disabled. Please do not forgot to reboot you server"
fi

echo -en "Secure SSH (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
  git clone https://github.com/m0zgen/secure-ssh.git
  bash secure-ssh/secure-ssh.sh
fi

# ---------------------------------------------------\

