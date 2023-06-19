# The ec2api::db::mysql class implements mysql backend for ec2api
#
# This class can be used to create tables, users and grant
# privilege for a mysql ec2api database.
#
# == Parameters
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
class ec2api::db::mysql (
  String[1] $password,
  String[1] $user    = 'ec2api',
  String[1] $dbname  = 'ec2api',
  String[1] $host    = '127.0.0.1',
  String[1] $charset = 'utf8',
  String[1] $collate = 'utf8_general_ci',
  $allowed_hosts     = undef
) {

  include ec2api::deps

  ::openstacklib::db::mysql { 'ec2api':
    user          => $user,
    password      => $password,
    dbname        => $dbname,
    host          => $host,
    charset       => $charset,
    collate       => $collate,
    allowed_hosts => $allowed_hosts,
  }

  Anchor['ec2api::db::begin']
  ~> Class['ec2api::db::mysql']
  ~> Anchor['ec2api::db::end']

}
