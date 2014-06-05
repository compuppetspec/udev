#!/bin/bash --login

rvm use 1.8.7-p374@udev --create
bundle install
git clone https://github.com/puppetlabs/puppetlabs_spec_helper.git
cd puppetlabs_spec_helper
rake package:gem
gem install pkg/puppetlabs_spec_helper-*.gem --ignore-dependencies --no-ri --no-RDoc
gem uninstall puppetlabs_spec_helper --version=0.4.1
rm -rf ../puppetlabs_spec_helper/
cd ../;rake spec
RESULT=$?
#rvm --force gemset delete 1.8.7-p374@udev
exit $RESULT
