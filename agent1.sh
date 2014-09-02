#!/bin/bash

sed -i -e 's/^environment.*$/environment\ =\ development/' /etc/puppetlabs/puppet/puppet.conf
