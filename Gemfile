source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'puppetlabs_spec_helper'
  gem 'puppet-blacksmith'
  gem 'puppet-lint'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', "=3.7.4", :require => false
end

# vim:ft=ruby
