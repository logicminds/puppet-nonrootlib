define nonrootlib::init_script(
  $config_dir_name,
  $config_file_name,
  $app_binary_path,
  $init_template,
  $pid_file_name             = "${name}.pid",
  $lock_file_name            = "${name}.lock",
  $options                   = {},
  $sysconfig_file_name       = $name,
  $ensure_value              = 'present',
  $init_script_mode          = '0744'

){

  include nonrootlib

  validate_string($pid_file_name, 2)
  validate_string($config_dir_name, 2)
  validate_string($config_file_name, 2)
  validate_string($lock_dir, 2)
  validate_string($app_binary_path, 2)

  if ! defined(File["${nonrootlib::etc_dir}/${config_dir_name}"]) {
    file{"${nonrootlib::etc_dir}/${config_dir_name}":
      ensure => 'directory'
    }
  }

  $config_file_path     = "${nonrootlib::etc_dir}/${config_dir_name}/${config_file_name}"
  $init_file_path       = "${nonrootlib::initd_dir}/${config_dir_name}/${config_file_name}"
  $pid_file_location    = "${nonrootlib::run_dir}/${pid_file_name}"
  $lock_file            = "${nonrootlib::lock_dir}/${lock_file_name}"
  $sysconfig_file_path  = "${nonrootlib::sysconfig_dir}/${sysconfig_file_name}"

  file{$init_file_path:
    ensure  => $ensure_value,
    mode    => $init_script_mode,
    content => template($init_template);
  }
}