# == Define aptly::mirror
#
# Manages an apt mirror.
#
define aptly::mirror (
  $location,
  $ensure        = 'present',
  $uid           = '450',
  $gid           = '450',
  $update        = true,
  $distribution  = $::lsbdistcodename,
  $architectures = [],
  $components    = [],
  $with_sources  = false,
  $with_udebs    = false,
  $keyring       = '/etc/apt/trusted.gpg'
) {
  validate_string(
    $distribution,
    $keyring
  )
  validate_array(
    $architectures,
    $components
  )
  validate_bool(
    $update,
    $with_sources,
    $with_udebs
  )
  validate_re($location, ['\Ahttps?:\/\/', '\Aftp:\/\/', '\A\/\w+'])

  aptly_mirror { $name:
    ensure        => $ensure,
    uid           => $uid,
    gid           => $gid,
    location      => $location,
    update        => $update,
    distribution  => $distribution,
    architectures => $architectures,
    components    => $components,
    with_sources  => $with_sources,
    with_udebs    => $with_udebs,
    keyring       => $keyring
  }
}
