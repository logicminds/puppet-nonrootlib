[![Build Status](https://travis-ci.org/logicminds/logicminds-nonrootlib.png)](https://travis-ci.org/logicminds/logicminds-nonrootlib)

## nonrootlib

Over the past few years I have written many puppet modules that do not have root access.  Over this time I have
developed a pattern for creating nonroot puppet modules.  This module intends to use many of the tricks, secrets and
patterns I have learned over the years.  While this module at the moment does not do much, it lays down a framework for any
future modules to inherit from.  This module should be thought of as a stdlib for nonroot puppet development.
Include this module in your classes or inherit it.

This module will set a posix like directory structure in the user home directory you specify.
By default it uses a fact to figure out the home directory, but all and any of these variables
can be overridden using a parameter.

You can use hiera to override any of the default parameters.

Using the nonrootlib kinda mandates that you follow a similar design pattern.  The design pattern in this module has a
few simple rules.

 1. You must create your own init scripts for controlling services in put them in the nonroot initd_dir.
     or templatize the ones usually included in many rpms and the /etc/init.d folders.
 2. You must use the variables in your classes, defines and templates so that directory structure will always stay in sync
    with your code.
 3. You must include, require or inherit the nonrootlib class so that you can access these variables.

### Features
1. init.pp creates a posix like directory structure just like you would have in a root environment
2. sysconfig define to allow you to easily create sysconfig files
3. init script define to allow you to easily create init script files for our services.
4. homedir fact
5. get_remote_data function to get json data from a remote destination
6. is_url_valid function to validate a url string

To access a variable just do the following

```puppet

   include nonrootlib

   info("Kaboom, my run directory is ${nonrootlib::run_dir}"

   file{"${nonrootlib::run_dir}/file1.txt": ensure => 'present'}

   # or use more memory and scope the variable to the your class
   $run_dir = nonrootlib::run_dir

```


### Example Usage inside another puppet module

```puppet

class puppet( $service_state = 'running'){

   # it becomes necessary to use variables for almost every single resource title.
   # Hard coding any paths will result in bugs in your code down the road when the
   # username changes or you change a nonrootlib parameter.
   #
   # By using the variables inside the nonrootlib class you now have a common
   # place to find out where files should go. Using these variables also makes coding puppet easier.

   # require the nonroot posix like directory structure like so.
   require nonrootlib

   $pconf_dir          = "${nonrootlib::install_core}/.puppet"
   $pidfile            = "${nonrootlib::run_dir}/agent.pid"
   $lockfile           = "${nonrootlib::subsys_dir}/puppet"
   $puppet_conf_file   = "${pconf_dir}/puppet.conf"

   file {"${pconf_dir}/classes.txt":
       ensure  => 'link',
       target  => "${pconf_dir}/var/state/classes.txt",
       require => File[$puppet_dirs]
     }
     file {"${nonrootlib::sysconfig_dir}/puppet":
       ensure  => present,
       mode    => '0750',
       content => template('puppet/sysconfig/puppet.erb'),
     }

     file {$puppet_conf_file:
       ensure  => present,
       mode    => '0750',
       content => template('puppet/puppet.conf.erb'),
       require => File[$pconf_dir],
     }
     file {"${pconf_dir}/auth.conf":
       ensure  => present,
       mode    => '0750',
       content => template('puppet/auth.conf.erb'),
       require => File[$pconf_dir],
     }
     file {"${nonrootlib::initd_dir}/puppet":
       ensure  => present,
       mode    => '0750',
       content => template('puppet/puppet.init.erb'),
     }

     file {"${nonrootlib::bin_dir}/puppet_check.sh":
       ensure  => present,
       mode    => '0750',
       content => template('puppet/puppet_check.sh.erb'),
     }
     file {"${nonrootlib::bin_dir}/puppetpostrun.sh":
       ensure  => present,
       mode    => '0750',
       content => template('puppet/puppet_post_run.sh.erb'),
     }

    # because we have a common place for our init files in our non root directory
    # we can use the service resource as it was intended, except with the init provider instead.

    service{"puppet":
       ensure => $service_state,
       provider => "init",
       hasstatus  => true,
       hasrestart => true,
       path       => $initd_dir,
       subscribe  => File[$puppet_conf_file, "${pconf_dir}/auth.conf",
       "${nonrootlib::initd_dir}/puppet", "${nonrootlib::sysconfig_dir}/puppet" ]
    }
}


```
### Moving forward with nonroot
My intentions with this module is for other people to use it and include it with their code, in hopes
that we can start to generate a lot of useful nonroot puppet modules for everyone to consume.  If this
module gets used a lot then it would be easy to setup a directory structure and write common nonroot services.
Almost every module on the puppet forge only works with root. Lets change that!


### Why sysinit scripts
I am kinda assuming that if you don't have root your probably not using ubuntu, debian other other systems that don't use
sysinit.
While this module should work perfectly under ubuntu, its not really meant for users who use upstart or systemd.
In the future I will probably explore the usage of these other init systems.  Systemd will end up replacing the
legacy sysinitv style scripts for redhat in the future anyways.  But lets see how systemd shakes out first.
Feel free to provide a PR for setting up a systemd or upstart system in nonroot.

### Contributing
Please fork this repo and issue a pull request.  Please write unit tests for your code.  If your not sure how to write
unit tests please have a look in my spec/classes/nonrootlib_spec.rb file.

### Custom Facts
    * home_dir  (gets the home directory of the user puppet runs as)

### Puppet Functions
    * get_remote_data (gets the contents of a remote url location)
    * is_valid_url  (validates the given url is a valid http url)

### Running unit tests

1. Install the necessary gems for unit tests.  (bundle install)
    * rspec-puppet
    * puppetlabs_spec_helper
    * puppet-lint
    * rake
    * rspec
    * json

2. rake spec

License
-------
Apache

Contact
-------
Corey Osman <cosman@logicminds.biz>

