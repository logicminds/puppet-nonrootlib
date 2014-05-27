require 'spec_helper'

describe 'nonrootlib::sysconfig' do
  let(:facts) do
    {:home_dir => '/home/user1',
     :owner => 'user1',
     :group => 'user1'
    }
  end
  let(:data) do
    {'demokey1' => 'value1', 'demokey2'=> 'value2'}
  end
  let(:params) do
    {
      'data' => data

    }
  end

  let(:title) do
    'rsyslog'
  end

  it { should contain_file('/home/user1/etc/sysconfig/rsyslog').with_content("demokey1=value1\ndemokey2=value2\n")}
end
