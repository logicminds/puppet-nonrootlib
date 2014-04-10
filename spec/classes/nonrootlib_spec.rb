require 'spec_helper'

describe 'nonrootlib' do
  let(:params) do
    {
      :install_core     => '/home/user1',
      :owner            => 'user1',
      :group            => 'user1',
      :etc_dir          =>"/home/user1/etc",
      :bin_dir          =>"/home/user1/bin",
      :var_dir          =>"/home/user1/var",
      :usr_dir          =>"/home/user1/usr",
      :tmp_dir          =>"/home/user1/tmp",
      :initd_dir        =>"/home/user1/etc/init.d",
      :lib_dir          =>"/home/user1/lib",
      :sysconfig_dir    =>"/home/user1/etc/sysconfig",
      :run_dir          =>"/home/user1/var/run",
      :lock_dir         =>"/home/user1/var/lock",
      :subsys_dir       =>"/home/user1/var/lock/subsys",
      :log_dir          =>"/home/user1/var/log"
      
    }
  end
  it { should contain_file('/home/user1/bin/service')}
  [ '/home/user1',
    '/home/user1/.bash_profile',
    '/home/user1/bin',
    '/home/user1/bin/service',
    '/home/user1/etc',
    '/home/user1/var',
    '/home/user1/usr',
    '/home/user1/lib',
    '/home/user1/etc/init.d',
    '/home/user1/etc/sysconfig',
    '/home/user1/var/run',
    '/home/user1/var/lock',
    '/home/user1/var/lock/subsys',
    '/home/user1/tmp',
    '/home/user1/var/log',
  ].each do |dir|
    it { should contain_file(dir).with_owner('user1').with_group('user1') }
  end

  describe 'using facts' do
    let(:facts) do
      {
        :id       => 'user2',
        :home_dir => '/home/user2'
      }
    end
    let(:params) do
      {}
    end

    [ '/home/user2',
      '/home/user2/.bash_profile',
      '/home/user2/bin',
      '/home/user2/bin/service',
      '/home/user2/etc',
      '/home/user2/var',
      '/home/user2/usr',
      '/home/user2/lib',
      '/home/user2/etc/init.d',
      '/home/user2/etc/sysconfig',
      '/home/user2/var/run',
      '/home/user2/var/lock',
      '/home/user2/var/lock/subsys',
      '/home/user2/tmp',
      '/home/user2/var/log',
    ].each do |dir|
      it { should contain_file(dir).with_owner('user2').with_group('user2') }
    end
  end
end

