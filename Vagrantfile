# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "tuupola/osx-mountain-lion-10.8-xcode"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
  end

  config.vm.provision "riak", type: "shell", path: "provision.sh", privileged: false

end
