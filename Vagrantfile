# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "tuupola/osx-mountain-lion-10.8-xcode"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
  end

  config.vm.define "builder", primary: true do |builder|
    builder.vm.provision "riak", type: "shell", path: "provision.sh", privileged: false
    builder.vm.network "private_network", ip: "192.168.199.2"
  end

  config.vm.define "test", autostart: false do |test|
    test.vm.provision "riak", type: "shell", path: "provision_test.sh", privileged: false
    test.vm.network "private_network", ip: "192.168.199.3"
  end
end
