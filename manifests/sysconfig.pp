# creates a key,value file in the sysconfig directory

define nonrootlib::sysconfig_file(
  $sysconfig_file_name = $name,
  $data = {}
){

  $sysconfig_file_path  = "${nonrootlib::sysconfig_dir}/${sysconfig_file_name}"

  file{$sysconfig_file_path:
    ensure => present,
    content => '<%= @data.each { |key, value| "#{key}=#{value}\n" } %>'
  }
}