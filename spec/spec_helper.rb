require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
RSpec.configure do |c|
  c.formatter = 'documentation'
  c.module_path = File.expand_path(File.join(__FILE__,  '..', '..', '..'))
end
#at_exit { RSpec::Puppet::Coverage.report! }
