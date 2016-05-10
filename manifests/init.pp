# == Class: ec2api
#
# The main EC2 API class to install and configure the service
#
# [*package_manage*]
#   Should the package be actually managed by Puppet?
#   Default: true
#
# [*package_ensure*]
#   The package ensure value. Can be present/absent/latest/purged
#   or the exact package version number.
#   Default: present
#
# [*package_name*]
#   The real package name.
#   Default: openstack-ec2-api
#
# [*package_provider*]
#   Override the provider used to manage the package.
#   Default: undef
#
class ec2api (
  $package_ensure   = 'present',
  $package_manage   = true,
  $package_name     = $::ec2api::params::package_name,
  $package_provider = undef,
) inherits ::ec2api::params {

  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_string($package_name)

  if $package_manage {
    package { 'ec2api' :
      ensure   => $package_ensure,
      name     => $package_name,
      provider => $package_provider,
    }

    Package['ec2api'] ->
    Class['ec2api::config']
  }

  include '::ec2api::config'
  include '::ec2api::logging'
  include '::ec2api::policy'
  include '::ec2api::db'

  anchor { 'ec2api-start' :} ->
  Class['ec2api::config'] ->
  Class['ec2api::db'] ->
  Class['ec2api::policy'] ->
  Class['ec2api::logging'] ->
  anchor { 'ec2api-end' :}

}
