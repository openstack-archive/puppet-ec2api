#
# Class to execute ec2api-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the ec2api-dbsync command.
#   Defaults to undef
#
class ec2api::db::sync(
  $extra_params  = undef,
) {
  exec { 'ec2api-db-sync':
    command     => "ec2api-manage db_sync ${extra_params}",
    path        => '/usr/bin',
    user        => 'ec2api',
    refreshonly => true,
    subscribe   => [Package['ec2api'], Ec2api_config['database/connection']],
  }

  Exec['ec2api-manage db_sync'] ~> Service<| title == 'ec2api' |>
}
