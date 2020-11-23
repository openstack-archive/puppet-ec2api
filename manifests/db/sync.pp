# == Class: ec2api::db::sync
#
# Class to execute "ec2api-manage db_sync"
#
# === Parameters
#
# [*system_user*]
#   (Optional) Run db_sync from this system user account.
#   Default to ec2api
#
# [*system_group*]
#   (Optional) Run db_sync by this system group.
#   Default to ec2api
#
# [*db_sync_timeout*]
#   (Optional) Timeout for the execution of the db_sync
#   Defaults to 300
#
class ec2api::db::sync (
  $system_user     = 'ec2api',
  $system_group    = 'ec2api',
  $db_sync_timeout = 300,
) {

  include ec2api::deps

  exec { 'ec2api_db_sync' :
    command     => 'ec2-api-manage db_sync',
    path        => '/usr/bin',
    user        => $system_user,
    group       => $system_group,
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    timeout     => $db_sync_timeout,
    logoutput   => on_failure,
    subscribe   => [
      Anchor['ec2api::install::end'],
      Anchor['ec2api::config::end'],
      Anchor['ec2api::dbsync::begin']
    ],
    notify      => Anchor['ec2api::dbsync::end'],
    tag         => 'openstack-db',
  }

}
