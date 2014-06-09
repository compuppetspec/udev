#!/bin/bash
source /etc/profile.d/rvm.sh
rvm use 1.8.7-p374@udev --create
export http_proxy=http://proxy:3128/
export https_proxy=https://proxy:3128/
bundle install
#presentstat=`gem list | grep puppetlabs_spec_helper| grep 0.5.0 | wc -l`
#if [[ ${presentstat} -eq 0 ]]
#then
#git clone https://github.com/puppetlabs/puppetlabs_spec_helper.git
#cd puppetlabs_spec_helper
#rake package:gem
#gem install pkg/puppetlabs_spec_helper-*.gem --ignore-dependencies --no-ri --no-RDoc
#rm -rf ../puppetlabs_spec_helper/
#cd ..
#fi
#gem uninstall puppetlabs_spec_helper --version=0.4.1
rake spec
RESULT=$?
#rvm --force gemset delete 1.8.7-p374@udev
exit $RESULT
