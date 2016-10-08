# The ec2api::db::mysql class implements mysql backend for ec2api
#
# This class can be used to create tables, users and grant
# privilege for a mysql ec2api database.
#
# == parameters
#
# [*password*]
#   (Mandatory) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'ec2api'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'ec2api'.
#
# [*host*]
#   (Optional) The default source host user is allowed to connect from.
#   Defaults to '127.0.0.1'
#
# [*allowed_hosts*]
#   (Optional) Other hosts the user is allowed to connect from.
#   Defaults to 'undef'.
#
# [*charset*]
#   (Optional) The database charset.
#   Defaults to 'utf8'
#
# [*collate*]
#   (Optional) The database collate.
#   Only used with mysql modules >= 2.2.
#   Defaults to 'utf8_general_ci'
#
# == Dependencies
#   Class['mysql::server']
#
# == Examples
#
# == Authors
#
# == Copyright
#
class ec2api::db::mysql (
  $password,
  $user          = 'ec2api',
  $dbname        = 'ec2api',
  $host          = '127.0.0.1',
  $charset       = 'utf8',
  $collate       = 'utf8_general_ci',
  $allowed_hosts = undef
) {
  validate_string($password)
  validate_string($dbname)
  validate_string($user)
  validate_string($host)
  validate_string($charset)
  validate_string($collate)

  ::openstacklib::db::mysql { 'ec2api':
    user          => $user,
    password_hash => mysql_password($password),
    dbname        => $dbname,
    host          => $host,
    charset       => $charset,
    collate       => $collate,
    allowed_hosts => $allowed_hosts,
  }

  ::Openstacklib::Db::Mysql['ec2api'] ~>
  Exec<| title == 'ec2api_db_sync' |>
}
