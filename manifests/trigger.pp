class udev::trigger inherits udev::params {
  exec { $udev::params::udevtrigger:
    refreshonly => true,
    path        => [$udev::params::udevadm_path],
  }
}

