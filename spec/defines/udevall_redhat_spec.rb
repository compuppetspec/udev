require 'spec_helper'

describe 'udev::rule' do
	let (:title) {'file.txt'}

	context 'With RedHat and ensure present' do
		let (:facts) {{ :osfamily=> 'redhat'}}
		context 'With file content available and Major release 5' do
			let (:facts) {{:osfamily=> 'redhat',:operatingsystemmajrelease=> '5'}}
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }		
			let (:params) {{:content => 'testdata',:ensure => 'present'}}	
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'present', 'content' => 'testdata') }
			it { should contain_class('udev::trigger').that_subscribes_to('File[/etc/udev/rules.d/file.txt]')}
			it do should contain_exec('udevtrigger').with(
        		    	'path'     => '/sbin',
		                'refreshonly' => 'true')
			end
		end


		context 'With source file available and Major release 5' do
			let (:facts) {{:osfamily=> 'redhat',:operatingsystemmajrelease=> '5'}}
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }
			let (:params) {{:source => '/tmp/temp.txt',:ensure => 'present'}}	
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'present', 'source' => '/tmp/temp.txt') }
			it { should contain_class('udev::trigger').that_subscribes_to('File[/etc/udev/rules.d/file.txt]')}
			it do should contain_exec('udevtrigger').with(
            		'path'     => '/sbin',
	                'refreshonly' => 'true')
			end
		end


		context 'With file content available and any other major release' do
			let (:facts) {{:osfamily=> 'redhat',:operatingsystemmajrelease=> 'X'}}
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }		
			let (:params) {{:content => 'testdata',:ensure => 'present'}}	
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'present', 'content' => 'testdata') }
			it { should contain_class('udev::trigger').that_subscribes_to('File[/etc/udev/rules.d/file.txt]')}
			it do should contain_exec('udevadm trigger').with(
        		    	'path'     => '/sbin',
		                'refreshonly' => 'true')
			end
		end


		context 'With source file available and any other Major release' do
			let (:facts) {{:osfamily=> 'redhat',:operatingsystemmajrelease=> 'X'}}
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }
			let (:params) {{:source => '/tmp/temp.txt',:ensure => 'present'}}	
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'present', 'source' => '/tmp/temp.txt') }
			it { should contain_class('udev::trigger').that_subscribes_to('File[/etc/udev/rules.d/file.txt]')}
			it do should contain_exec('udevadm trigger').with(
            		'path'     => '/sbin',
	                'refreshonly' => 'true')
			end
		end


		context 'With neither source nor content available' do
			let(:params) {{:ensure => 'present'}}
			it do
        		        expect {should compile}.to raise_error(Puppet::Error, /file.txt: must specify content or source/)
                	end		
		end


		context 'With both source nor content available' do
			let(:params) {{:ensure => 'present',:source => '/tmp/temp.txt',:content => 'testdata'}}
			it do
        	        expect {should compile}.to raise_error(Puppet::Error, /file.txt: must specify content or source not both/)
	                end		
		end

	end

	context 'With RedHat and ensure absent' do
		let (:facts) {{ :osfamily=> 'redhat'}}
		
		context 'With content data available' do
			let (:params) {{:content => 'testdata',:ensure => 'absent'}}		
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'absent') }
		end

		context 'With source file available' do
			let (:params) {{:source => '/tmp/temp.txt',:ensure => 'absent'}}		
			it { should contain_class('udev')}	
			it { should contain_package('udev').with_ensure('installed') }
			it { should contain_file('/etc/udev/rules.d/file.txt').with('ensure' => 'absent') }
		end

	end

	context 'With Unsupported Operating systems' do
		let (:facts) {{ :osfamily=> 'solaris',:operatingsystem =>'solaris'}}
		it do
        	        expect {should compile}.to raise_error(Puppet::Error, /Module udev is not supported on solaris/)
                end	
	end
end
