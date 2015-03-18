require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint'
Blacksmith::RakeTask.new do |t|
  t.tag_pattern = "v%s" # Use a custom pattern with git tag. %s is replaced with the version number.
end

PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send("disable_quoted_booleans")
