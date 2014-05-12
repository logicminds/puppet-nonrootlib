# == Class: nonrootlib
#

# === Authors
#
# Corey Osman <corey@logicminds.biz>
#
#
class nonrootlib(
  $install_core     = $::home_dir,
  $owner            = $::id,
  $group            = $::id,
  $etc_dir          = "${::home_dir}/etc",
  $bin_dir          = "${::home_dir}/bin",
  $var_dir          = "${::home_dir}/var",
  $usr_dir          = "${::home_dir}/usr",
  $tmp_dir          = "${::home_dir}/tmp",
  $initd_dir        = "${::home_dir}/etc/init.d",
  $lib_dir          = "${::home_dir}/lib",
  $sysconfig_dir    = "${::home_dir}/etc/sysconfig",
  $run_dir          = "${::home_dir}/var/run",
  $lock_dir         = "${::home_dir}/var/lock",
  $subsys_dir       = "${::home_dir}/var/lock/subsys",
  $log_dir          = "${::home_dir}/var/log"
)
{
	# set the directories to be created in this array.  Order matters! Puppet will create each directory in the position
	# you define.
  $directories      = [ $install_core, $etc_dir, $bin_dir, $var_dir, $usr_dir, $tmp_dir, $initd_dir, $lib_dir,
                        $sysconfig_dir, $run_dir, $lock_dir, $subsys_dir, $log_dir  ]

  $bash_profile = "${install_core}/.bash_profile"

  File {
    owner  => $owner,
    group  => $group,
    mode   => '0750',
  }

  file { $directories:
    ensure => 'directory',
  }

  file {"${bin_dir}/service":
    ensure  => 'present',
    content => template('nonrootlib/service.erb'),
    require => File[$bin_dir]
  }
  file { $bash_profile:
    ensure  => 'present',
    content => template('nonrootlib/.bash_profile.erb'),
    require => File[$install_core]
  }


}
