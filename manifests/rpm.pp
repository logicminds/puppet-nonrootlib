class nonrootlib::rpm(
    $dbpath
)
{
   $rpmrc_file = "${nonrootlib::install_core}/.rpmrc"
   # Set some default options to pick up the database that we created with this class
   # alternatively we could create an rpm macro file .rpmrc file with the dbpath
   # but I can't get this to work yet
   Package{
    install_options => [ "--dbpath ${dbpath}" ],
    uninstall_options => [ "--dbpath ${dbpath}" ]
   }

   file{$rpmrc_file:
    ensure => present,
    content => template('nonrootlib/rpmrc.erb')
   }

}