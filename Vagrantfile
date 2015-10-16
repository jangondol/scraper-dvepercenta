# -*- mode: ruby -*-
# vi: set ft=ruby :

# system "vagrant plugin install vagrant-vbguest" unless Vagrant.has_plugin? "vagrant-vbguest"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "run.sh", privileged: false
  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    # vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--memory", "768"]
  end
end
