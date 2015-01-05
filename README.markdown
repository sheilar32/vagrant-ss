This repo holds a stock vagrant implementation for use in consulting engagements.

In the rollup, I have:

Puppet Master with Puppet Enterprise 3.7.1
Puppet Agents 1-3, all customized to the following three environments:
- development
- testing
- production

REQUIRED:
To use this module with your current Vagrant Implementation, you have to install two vagrant plugins:
- vagrant-hosts<br>
- vagrant-pe_build<br>

To install the required plugins, on your local system simply run:

vagrant plugin install vagrant-hosts<br>
vagrant plugin install vagrant-pe_build<br>

to prepare Vagrant to use the included Vagrantfile.

NOTES:

With the default installaiton of PE 3.7.1, the installer automatically creates the directory 
/etc/puppetlabs/puppet/environments/production.  As a result, when r10k attempts to deploy
to your instance, it fails because this directory already exists.  This is an artifact of the
underlying Git operation that cannot clone to a pre-existing directory.  This is a known r10k
issue, and is slated for the next release.  Until then, I am renaming this directory and 
deploying into that location.  

TODO:
- Windows testing
- Linux Testing
- OSX regression
- VMWare Fusion Support
- Git Server based locally and master pointed to Git
- Sometimes the vagrant package will not download the Puppet Enterprise properly.  Needs resolution.
