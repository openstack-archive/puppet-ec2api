# == Class: ec2api::db::postgresql
#
# Class that configures postgresql for ec2api
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'ec2api'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'ec2api'.
#
# [*encoding*]
#   (Optional) The charset to use for the database.
#   Default to undef.
#
# [*privileges*]
#   (Optional) Privileges given to the database user.
#   Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class ec2api::db::postgresql (
  $password,
  $user       = 'ec2api',
  $dbname     = 'ec2api',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  Class['ec2api::db::postgresql'] ->
  Service<| tag == 'ec2api' |>

  ::openstacklib::db::postgresql { 'ec2api':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['ec2api'] ~>
  Exec<| title == 'ec2api_db_sync' |>
}
