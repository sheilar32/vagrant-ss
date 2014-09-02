# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
config.vm.box = "centos-65-x64-nocm"
config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"

pe_version = '3.2.3'
config.pe_build.version       = pe_version
config.pe_build.download_root = "https://s3.amazonaws.com/pe-builds/released/#{pe_version}"

## Master
config.vm.define :master do |master|
config.vm.provision :shell, path: "master.sh"

master.vm.provider :virtualbox do |v|
v.memory  = 1024
v.cpus = 2
end

master.vm.network :private_network,  ip: "10.10.100.100"
master.vm.network "forwarded_port", guest: 443, host: 8443
master.vm.hostname = 'master.puppetlabs.vm'
master.vm.provision :hosts

master.vm.provision :pe_bootstrap do |pe|
pe.role = :master
end

config.vm.provision "shell", 
	inline: "service iptables stop"
	end

## agent 1
	config.vm.define :agent1 do |agent|
  config.vm.provision :shell, path: "agent1.sh"

	agent.vm.provider :virtualbox
	agent.vm.network :private_network,  ip: "10.10.100.111"

	agent.vm.hostname = 'agent1.puppetlabs.vm'
	agent.vm.provision :hosts

	agent.vm.provision :pe_bootstrap do |pe|
	pe.role   =  :agent
	pe.master = 'master.puppetlabs.vm'
	end
	end

## agent 2
	config.vm.define :agent2 do |agent|
  config.vm.provision :shell, path: "agent2.sh"

	agent.vm.provider :virtualbox
	agent.vm.network :private_network,  ip: "10.10.100.112"

	agent.vm.hostname = 'agent2.puppetlabs.vm'
	agent.vm.provision :hosts

	agent.vm.provision :pe_bootstrap do |pe|
	pe.role   =  :agent
	pe.master = 'master.puppetlabs.vm'
	end
	end

## agent 3
	config.vm.define :agent3 do |agent|
  config.vm.provision :shell, path: "agent3.sh"

	agent.vm.provider :virtualbox
	agent.vm.network :private_network,  ip: "10.10.100.113"

	agent.vm.hostname = 'agent3.puppetlabs.vm'
	agent.vm.provision :hosts

	agent.vm.provision :pe_bootstrap do |pe|
	pe.role   =  :agent
	pe.master = 'master.puppetlabs.vm'
	end
	end

## Git
	config.vm.define :git do |agent|
  config.vm.provision :shell, path: "git.sh"

	agent.vm.provider :virtualbox
	agent.vm.network :private_network,  ip: "10.10.100.114"

	agent.vm.hostname = 'git.puppetlabs.vm'
	agent.vm.provision :hosts

	agent.vm.provision :pe_bootstrap do |pe|
	pe.role   =  :agent
	pe.master = 'master.puppetlabs.vm'
	end
	end
  end
