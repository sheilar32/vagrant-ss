#!/bin/bash

# Perform a few steps first
export PATH=$PATH:/opt/puppet/bin
/opt/puppet/bin/puppet module install zack/r10k
/sbin/service iptables stop

# Place the r10k configuration file
cat > /var/tmp/configure_r10k.pp << 'EOF'
class { 'r10k':
  version           => '1.4.0',
  sources           => {
    'puppet' => {
      'remote'  => 'https://github.com/cvquesty/puppet_repository.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    }
  },
  purgedirs         => ["${::settings::confdir}/environments"],
  manage_modulepath => false,
}
EOF

# Place the directory environments config file
cat > /var/tmp/configure_directory_environments.pp << 'EOF'
######                           ######
##  Configure Directory Environments ##
######                           ######

##  This manifest requires the puppetlabs/inifile module and will attempt to
##  configure puppet.conf according to the blog post on using R10k and
##  directory environments.  Beware!

# Default for ini_setting resources:
Ini_setting {
  ensure => present,
  path   => "${::settings::confdir}/puppet.conf",
}

ini_setting { 'Configure environmentpath':
  section => 'main',
  setting => 'environmentpath',
  value   => '$confdir/environments',
}

ini_setting { 'Configure basemodulepath':
  section => 'main',
  setting => 'basemodulepath',
  value   => '$confdir/modules:/opt/puppet/share/puppet/modules',
}
EOF

# Now place the hiera.yaml in the proper location
cat > /etc/puppetlabs/puppet/hiera.yaml << 'EOF'
---
:backends:
  - yaml
:hierarchy:
  - "%{clientcert}"
  - "%{application_tier}"
  - common
:yaml:
# datadir is empty here, so hiera uses its defaults:
# - /var/lib/hiera on *nix
# - %CommonAppData%\PuppetLabs\hiera\var on Windows
# When specifying a datadir, make sure the directory exists.
  :datadir: "/etc/puppetlabs/puppet/environments/%{environment}/hieradata"
EOF

# Now, apply your new configuration
/opt/puppet/bin/puppet apply /var/tmp/configure_r10k.pp

# Then configure directory environments
/opt/puppet/bin/puppet apply /var/tmp/configure_directory_environments.pp

# Handle the r10k Bug
/bin/mv /etc/puppetlabs/puppet/environments/production /etc/puppetlabs/puppet/environments/production-ORIG

# Do the first deployment run
/opt/puppet/bin/r10k deploy environment -pv

# Restart Puppet to pick up the new hiera.yaml
/sbin/service pe-puppet restart
/sbin/service pe-httpd restart
