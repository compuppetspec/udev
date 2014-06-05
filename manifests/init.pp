class udev inherits udev::params {  
  package{ $udev::params::udev_package:
    ensure => $udev::params::udev_package_ensure,
  }
}
