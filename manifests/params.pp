class udev::params {
  $udev_package        = 'udev'
  $udev_package_ensure = 'installed'
  $udevadm_path        = '/sbin'

  $states = $::osfamily ?{
    'debian' => [
      'absent',
      'installed',
      'latest',
      'present',
      'purged'
    ],
    default => [
      'absent',
      'installed',
      'latest',
      'present',
    ]
  }
  validate_re($udev_package_ensure, $states)
  validate_string($udev_package)
  case $::osfamily {
    'debian': {
      $udevtrigger     = 'udevadm trigger'
    }
    'redhat': {
      case $::operatingsystemmajrelease {
        '5': {
          $udevtrigger = 'udevtrigger'
        }
        default: {
          $udevtrigger = 'udevadm trigger'
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
