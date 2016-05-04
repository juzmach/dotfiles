# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.define "ubuntu-dotfiles" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.provider :virtualbox do |vb|
      vb.name = "ubuntu-dotfiles"
      vb.cpus = 2
      vb.memory = 4096
      vb.gui = true
    end
    ubuntu.vm.provision :shell, inline: "apt-get update && apt-get -y upgrade"
  end

end
