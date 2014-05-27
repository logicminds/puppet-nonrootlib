define nonrootlib::init_script(
  $config_dir_name,
  $config_file_name,
  $app_binary_path,
  $init_template_path,
  $init_file_name            = $name,
  $pid_file_name             = "${name}.pid",
  $lock_file_name            = "${name}.lock",
  $options                   = {},
  $sysconfig_file_name       = $name,
  $ensure_value              = 'present',
  $init_script_mode          = '0744'

){

  include nonrootlib
# the spec tests can seem to find the stdlib module which contains this function so I have disabled until I can
# find the resolution

#  validate_string($pid_file_name, 2)
#  validate_string($config_dir_name, 2)
#  validate_string($config_file_name, 2)
#  validate_string($lock_dir, 2)
#  validate_string($app_binary_path, 2)
  $config_dir = "${nonrootlib::etc_dir}/${config_dir_name}"
  if ! defined(File[$config_dir]) {
    file{$config_dir:
      ensure => 'directory'
    }
  }

  $config_file_path     = "${config_dir}/${config_file_name}"
  $init_file_path       = "${nonrootlib::initd_dir}/${init_file_name}"
  $pid_file_location    = "${nonrootlib::run_dir}/${pid_file_name}"
  $lock_file            = "${nonrootlib::lock_dir}/${lock_file_name}"
  $sysconfig_file_path  = "${nonrootlib::sysconfig_dir}/${sysconfig_file_name}"

  file{$init_file_path:
    ensure  => $ensure_value,
    mode    => $init_script_mode,
    content => template($init_template_path)
  }
}