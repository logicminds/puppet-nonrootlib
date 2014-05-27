# creates a key,value file in the sysconfig directory
define nonrootlib::sysconfig(
  $sysconfig_file_name      = $name,
  $data                     = {},
  $template                 = 'nonrootlib/sysconfig.erb',
  $ensure_value             = 'present'
){
  include nonrootlib
  $sysconfig_file_path  = "${nonrootlib::sysconfig_dir}/${sysconfig_file_name}"


  file{$sysconfig_file_path:
    ensure  => $ensure_value,
    content => template($template),
  }
}