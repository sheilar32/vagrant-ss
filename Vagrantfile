# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
config.vm.box = "centos-65-x64-nocm"
config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"

pe_version = '3.3.0'
config.pe_build.version       = pe_version
config.pe_build.download_root = "https://s3.amazonaws.com/pe-builds/released/#{pe_version}"

## Master
  config.vm.define :master do |master|
	  master.vm.provider :virtualbox do |v|
	    v.memory  = 1024
      v.name = "master"
	    v.cpus = 2
	  end

	  master.vm.network :private_network,  ip: "10.10.100.100"
	  master.vm.network "forwarded_port", guest: 443, host: 8443
	  master.vm.hostname = 'master.puppetlabs.vm'
	  master.vm.provision :hosts
	  master.vm.provision :pe_bootstrap do |pe|
	    pe.role = :master
	  end
	  master.vm.provision :shell, path: "master.sh"
  end

## Development
	config.vm.define :development do |development|
		development.vm.provider :virtualbox do |v|
      v.memory = 512
      v.name = "development"
      v.cpus = 1
    end
		development.vm.network :private_network,  ip: "10.10.100.111"
		development.vm.hostname = 'development.puppetlabs.vm'
		development.vm.provision :hosts
		development.vm.provision :pe_bootstrap do |pe|
			pe.role   =  :agent
			pe.master = 'master.puppetlabs.vm'
		end
  	development.vm.provision :shell, path: "development.sh"
  end

## Testing
	config.vm.define :testing do |testing|
	testing.vm.provider :virtualbox do |v|
  	v.memory = 512
		v.name = "testing"
		v.cpus = 1
  end
	testing.vm.network :private_network,  ip: "10.10.100.112"
	testing.vm.hostname = 'testing.puppetlabs.vm'
	testing.vm.provision :hosts
	testing.vm.provision :pe_bootstrap do |pe|
		pe.role   =  :agent
		pe.master = 'master.puppetlabs.vm'
	end
  testing.vm.provision :shell, path: "testing.sh"
end

## Production
	config.vm.define :production do |production|
	production.vm.provider :virtualbox do |v|
		v.memory = 512
		v.name = "production"
		v.cpus = 1
	end
	production.vm.network :private_network,  ip: "10.10.100.113"
	production.vm.hostname = 'production.puppetlabs.vm'
	production.vm.provision :hosts
	production.vm.provision :pe_bootstrap do |pe|
		pe.role   =  :agent
		pe.master = 'master.puppetlabs.vm'
	end
  production.vm.provision :shell, path: "production.sh"
end

## Git
	config.vm.define :git do |git|
	git.vm.provider :virtualbox do |v|
		v.memory = 512
		v.name = "git"
		v.cpus = 1
	end
	git.vm.network :private_network,  ip: "10.10.100.114"
	git.vm.hostname = 'git.puppetlabs.vm'
	git.vm.provision :hosts
	git.vm.provision :pe_bootstrap do |pe|
		pe.role   =  :agent
		pe.master = 'master.puppetlabs.vm'
	end
  git.vm.provision :shell, path: "git.sh"
end
end
