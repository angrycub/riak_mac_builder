# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "tuupola/osx-mountain-lion-10.8-xcode"
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
  end

  config.vm.define "builder" do |builder|
    builder.vm.provision "riak", type: "shell", path: "provision.sh", privileged: false
  end

  config.vm.define "test" do |test|
    test.vm.provision "riak", type: "shell", path: "provision_test.sh", privileged: false
  end
end
