# Parameters for puppet-ec2api
#
class ec2api::params {

  case $::osfamily {
    'RedHat': {
      $package_name = 'openstack-ec2-api'
      $sqlite_package_name  = undef
      $pymysql_package_name = undef
    }
    'Debian': {
      $package_name = 'ec2api'
      $sqlite_package_name  = 'python-pysqlite2'
      $pymysql_package_name = 'python-pymysql'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily

}
