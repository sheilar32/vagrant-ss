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

Because of GitHub's copious use of "master" as the default branch, you end up with a "master" 
branch & directory environment.  Puppet Labs' documentation states that "master" is a reserved
word, and cannot be used as an environment name.  So, you should refrain from using this 
environment.  I plan on removing it in future versions of vagrant-ss, I just have to do 
development in-between professional services engagements.

With the default installaiton of PE 3.7.1, the installer automatically creates the directory 
/etc/puppetlabs/puppet/environments/production. <strong>As a result, when r10k attempts to deploy
to your instance, it fails because this directory already exists.  This is an artifact of the
underlying Git operation that cannot clone to a pre-existing directory.  This is a known r10k
issue, and is slated for the next release.  Until then, I am renaming this directory and 
deploying into that location.</strong>

Linux testing is now complete.  After a professional services engagement recently, I had a 
number of students need to use the instance who were all Linux users, and they were able to
"fire test" for me.  Issues, if any, should be opened on the project in the GitHub page.


TODO:
- VMWare Fusion Support
  - I have one pull request on VMWare Fusion, and it's a hacky sort of substitute,
    If anyone nows how to get the Vagrantfile to determine the right virtualization
    technology and just "do the right thing" all in one Vagrantfile, that's the 
    "silver bullet" I'm looking for.
- Git Server based locally and master pointed to Git
- Sometimes the vagrant package will not download the Puppet Enterprise properly.  Needs resolution.
- Look into removing the master branch, and only have "development, testing, and production" branches.
