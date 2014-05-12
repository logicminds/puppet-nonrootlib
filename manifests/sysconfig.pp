# creates a key,value file in the sysconfig directory

define nonrootlib::sysconfig_file(
  $sysconfig_file_name = $name,
  $data = {}
  $template = '<%= @data.each { |key, value| "#{key}=#{value}\n" } %>'
  $ensure_value = 'present'
){

  $sysconfig_file_path  = "${nonrootlib::sysconfig_dir}/${sysconfig_file_name}"

  file{$sysconfig_file_path:
    ensure => $ensure_value,
    content => $template,
  }
}