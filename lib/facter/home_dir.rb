require 'etc'
Facter.add("home_dir") do
  confine :kernel => "Linux"
  setcode do
    Etc.getpwuid.dir
  end
end
