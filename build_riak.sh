#! /bin/bash
export RIAK_VERSION=2.2.1rc3


print_time () {
	echo "==========  $(date)  =========="
}


echo "* Cloning Riak EE Repo"
cd ~
git clone git@github.com:basho/riak_ee.git
cd riak_ee
git checkout riak_ee-${RIAK_VERSION}
print_time

echo "* Building Riak EE Packages"
make package
cp package/packages/* /vagrant/packages
print_time

echo "* Cloning Riak Repo"
git clone https://github.com/basho/riak
cd riak
git checkout riak-${RIAK_VERSION}
print_time

echo "* Building Riak Packages"
make package
cp package/packages/* /vagrant/packages
print_time
