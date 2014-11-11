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

to prepare Vagrant to use the included Vagrantfile.

TODO:
- Windows testing
- Linux Testing
- OSX regression
- VMWare Fusion Support
- Git Server based locally and master pointed to Git
- Sometimes the vagrant package will not download the Puppet Enterprise properly.  Needs resolution.
