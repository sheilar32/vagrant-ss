#!/bin/bash

# Perform a few steps first
export PATH=$PATH:/opt/puppet/bin
/opt/puppet/bin/puppet module install zack/r10k
/sbin/service iptables stop
/bin/mkdir -p /etc/puppetlabs/puppet/environments
/bin/mkdir -p /etc/puppetlabs/puppet/hiera
/bin/mkdir -p /etc/puppetlabs/facter/facts.d

# Place the r10k configuration file
cat > /var/tmp/configure_r10k.pp << 'EOF'
class { 'r10k':
  version           => '1.3.2',
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

# Now, apply your new configuration
/opt/puppet/bin/puppet apply /var/tmp/configure_r10k.pp

# Do the first deployment run
/usr/bin/r10k deploy environment -pv
