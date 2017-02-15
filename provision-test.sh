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

echo "
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>limit.maxfiles</string>
<key>ProgramArguments</key>
<array>
<string>launchctl</string>
<string>limit</string>
<string>maxfiles</string>
<string>262144</string>
<string>262144</string>
</array>
<key>RunAtLoad</key>
<true/>
<key>ServiceIPC</key>
<false/>
</dict>
</plist>
" >> /Library/LaunchDaemons/limit.maxfiles.plist

echo "* Upping ulimit in .profile"
echo "
ulimit -n 65536
" >> /Users/vagrant/.profile