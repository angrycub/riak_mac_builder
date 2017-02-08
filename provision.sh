#! /bin/bash

print_time () {
	echo "==========  $(date)  =========="
}

print_time 

echo "* Modify Taskgated configuration"
# For some reason the `git` tests seriously irritate taskgated and
# will cause the git build to take > 20 minutes. Add `-p` option
# to /System/Library/LaunchDaemons/com.apple.taskgated.plist
# file. 

echo " - stopping and unloading taskgated"
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.taskgated.plist
echo " - creating backup file /System/Library/LaunchDaemons/com.apple.taskgated.plist.orig"
sudo mv /System/Library/LaunchDaemons/com.apple.taskgated.plist /System/Library/LaunchDaemons/com.apple.taskgated.plist.orig
echo " - modifying file"
sudo sed -e 's|<string>-s</string>|<string>-sp</string>|g' /System/Library/LaunchDaemons/com.apple.taskgated.plist.orig > com.apple.taskgated.plist
sudo mv com.apple.taskgated.plist /System/Library/LaunchDaemons/com.apple.taskgated.plist
echo " - restarting taskgated"
sudo launchctl load /System/Library/LaunchDaemons/com.apple.taskgated.plist

print_time

echo "* Kerl"
echo " - installing kerl"
curl -s -O https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod +x kerl
echo " - building .kerlrc"
echo 'THIS KERLRC EXPECTS A 

export LDFLAGS="-L/usr/local/opt/unixodbc/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/libxslt/lib" 
export CPPFLAGS="-I/usr/local/opt/unixodbc/include -I/usr/local/opt/openssl/include" 
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:/usr/local/opt/libxslt/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig"

KERL_CONFIGURE_OPTIONS="--disable-hipe --enable-smp-support --enable-threads
                        --enable-kernel-poll --enable-darwin-64bit
                        --disable-dynamic-ssl-lib"
' >> .kerlrc

echo "* Configuring git for HTTPS"
git config --global url."https://github.com/".insteadOf git@github.com:
git config --global url."https://".insteadOf git://

print_time

echo "* Install HomeBrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null

print_time

echo "* Brew in dependencies"
echo " - Cask dependencies"
brew cask install java
echo " - plain brew formulae"
# brew install git
brew install openssl autoconf unixodbc wxmac fop libxslt

print_time

echo "* Basho OTP R16B02-basho10"
echo " **Note**: This process will take a long time and provide almost no feedback."
echo 
echo " - Building R16B02-basho10"
./kerl build git git://github.com/basho/otp.git OTP_R16B02_basho10 R16B02-basho10
# **Optional**: To monitor the build process, you can open another session to the VM and run the following: `tail -f /Users/vagrant/.kerl/builds/R16B02-basho10/otp_build_git.log`
print_time

echo " - Installing R16B02-basho10"
./kerl install R16B02-basho10 ~/erlang/R16B02-basho10
echo " - Activating R16B02-basho10"
. /Users/vagrant/erlang/R16B02-basho10/activate
echo " - adding to .profile"
echo ". /Users/vagrant/erlang/R16B02-basho10/activate" > .profile
print_time

echo "* Cloning Riak Repo"
git clone https://github.com/basho/riak
cd riak
git checkout riak-2.2.0

print_time

exit 0 
echo "* Building Riak Packages"
make package

print_time
