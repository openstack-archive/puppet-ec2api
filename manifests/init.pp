# == Class: ec2api
#
# Full description of class ec2api here.
#
# === Parameters
#
# [*package_ensure*]
#    (Optional) Ensure state for package.
#    Defaults to 'present'
#
# [*package_manage*]
#    (Optional) Activate/deactivate ec2api package installation.
#    Defaults to true
#
#
class ec2api (
  $package_ensure = 'present',
  $package_manage = true,
) {

  include ::ec2api::params

  include ::ec2api::db
  include ::ec2api::logging
  include ::ec2api::policy

  if $package_manage {
    package { 'ec2api':
      ensure => $package_ensure,
      name   => $::ec2api::params::package_name,
      tag    => ['openstack', 'ec2api-package'],
    }

    Package['ec2api'] ->
    File <| title == 'ec2-api-config-file' |>

    Package['ec2api'] ->
    File <| title == 'ec2-api-paste-ini-file' |>
  }
}
