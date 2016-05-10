# == Class: ec2api::db::sync
#
# Class to execute "ec2api-manage db_sync"
#
# === Parameters
#
# [*system_user*]
#   Run db_sync from this system user account.
#   Default: ec2api
#
# [*system_group*]
#   Run db_sync by this system group.
#   Default: ec2api
#
class ec2api::db::sync (
  $system_user  = 'ec2api',
  $system_group = 'ec2api',
) inherits ::ec2api::params {

  exec { 'ec2api_db_sync' :
    command     => 'ec2api-manage db_sync',
    path        => '/usr/bin',
    user        => $system_user,
    group       => $system_group,
    refreshonly => true,
  }

  Package <| title == 'ec2api' |> ~>
  Exec['ec2api_db_sync']

  Ec2api_config <| title == 'database/connection' |> ~>
  Exec['ec2api_db_sync']

  User <| title == 'ec2api' |> ->
  Exec['ec2api_db_sync']

  Exec['ec2api_db_sync'] ~>
  Service<| tag == 'ec2api-service' |>

  Exec['ec2api_db_sync'] ~>
  Service<| tag == 'ec2api-service' |>

  Exec['ec2api_db_sync'] ~>
  Service<| tag == 'ec2api-service' |>
}
