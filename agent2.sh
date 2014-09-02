#!/bin/bash

sed -i -e 's/^environment.*$/environment\ =\ testing/' /etc/puppetlabs/puppet/puppet.conf
