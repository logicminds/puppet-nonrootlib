require 'spec_helper'

describe 'nonrootlib::init_script' do
  let(:facts) do
    {:home_dir => '/home/user1',
     :owner => 'user1',
     :group => 'user1'
    }
  end
  let(:params) do
    {:config_dir_name => 'rsyslogd',
     :config_file_name => 'rsyslogd.conf',
     :app_binary_path => '/usr/sbin/rsyslogd',
     :init_template_path => 'rsyslog/rsyslogd.init.erb'
    }
  end
  let (:title) do
     'rsyslogd'
  end
  it { is_expected.to contain_file('/home/user1/etc/init.d/rsyslogd') }
  it { is_expected.to contain_file('/home/user1/etc/rsyslogd').with_ensure('directory') }


end
