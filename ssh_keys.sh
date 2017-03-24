echo "* Importing SSH keys and registering"
cp /vagrant/keys/* ~/.ssh
chmod 600 ~/.ssh/ssh_*
for I in ssh-*; do ssh-add ${I}; done