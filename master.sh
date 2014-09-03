#!/bin/bash

# Perform a few steps first
/opt/puppet/bin/puppet module install zack/r10k
/sbin/service iptables stop
/bin/mkdir -p /etc/puppetlabs/puppet/environments

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

# Now, apply your new configuration
/opt/puppet/bin/puppet apply /var/tmp/configure_r10k.pp

# Do the first deployment run
/usr/bin/r10k deploy environment -pv
