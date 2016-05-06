# Parameters for puppet-ec2api
#
class ec2api::params {

  case $::osfamily {
    'RedHat': {
      $package_name = 'openstack-ec2-api'
    }
    'Debian': {
      $package_name = 'ec2api'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily

}
