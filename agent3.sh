#!/bin/bash

sed -i -e 's/environment.*$/environment\ =\ production/' /etc/puppetlabs/puppet/puppet.conf
