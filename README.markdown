This repo holds a stock vagrant implementation for use in consulting engagements.

In the rollup, I have:

Puppet Master with Puppet Enterprise 3.3
Puppet Agents 1-3, all customized to the following three environments:
- development
- testing
- production

REQUIRED:
To use this module with your current Vagrant Implementation, you have to install two vagrant plugins:
- vagrant-hosts
- vagrant-pe_build

To install the required plugins, on your local system simply run:

vagrant plugin install vagrant-hosts
vagrant plugin install vagrant-pe_build

NOTE:  As of the release of OSX 10.10 Yosemite, the hostnames no longer work 
and throw the errors regarding not being able to resolve names properly.

to prepare Vagrant to use the included Vagrantfile.

TODO:
- Windows testing
- Linux Testing
- OSX regression
- VMWare Fusion Support
