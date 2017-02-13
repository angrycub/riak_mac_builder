#! /bin/bash

print_time () {
	echo "==========  $(date)  =========="
}

print_time 

echo "* Upping ulimit"
echo "
kern.maxfiles=524288
kern.maxfilesperproc=262144
" >> /etc/sysctl.conf