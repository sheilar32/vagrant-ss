This repo holds a stock vagrant implementation for use in consulting engagements.

In the rollup, I have:

Puppet Master with Puppet Enterprise 3.3
Puppet Agents 1-3, all customized to the following three environments:
- development
- testing
- production
One Git Server with a full Git software installation


TODO:

Automatically install & provision r10k to talk to the git server and pull down a full sample repo
for testing and development.

