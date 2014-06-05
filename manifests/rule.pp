## provides udev rules
define udev::rule(
  $ensure  = present,
  $content = undef,
  $source  = undef
) {
  validate_re($ensure, '^present$|^absent$')

  include udev
  include udev::trigger

  if $source and $content {
    fail("${title}: must specify content or source not both")
  }elsif !$source and !$content {
    fail("${title}: must specify content or source")
  }else {
    if $source {
      validate_string($source)
    }else{
      validate_string($content)
    }
  }

  $config = {
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $content,
    source  => $source,
    notify  => Class['udev::trigger'],
  }

  create_resources( 'file', { "/etc/udev/rules.d/${title}" => $config } )

}
