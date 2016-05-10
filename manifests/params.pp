# == Class: ec2api::params
#
# These parameters need to be accessed from several locations and
# should be considered to be constant
#
class ec2api::params {
  case $::osfamily {
    'RedHat': {
      $package_name          = 'openstack-ec2-api'
      $api_service_name      = 'openstack-ec2-api'
      $metadata_service_name = 'openstack-ec2-api-metadata'
      $s3_service_name       = 'openstack-ec2-api-s3'
    }
    'Debian': {
      # FIXME: Correct these variables once UCA provides ec2-api packaging
      $package_name          = 'ec2api'
      $api_service_name      = 'ec2-api'
      $metadata_service_name = 'ec2-api-metadata'
      $s3_service_name       = 'ec2-api-s3'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }
  }
}
