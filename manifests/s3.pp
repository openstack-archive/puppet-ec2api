# == Class: ec2api::s3
#
# Manage the EC2 S3 service and its configuration
#
# === Parameters
#
# ==== S3 Server
#
# [*buckets_path*]
#   Path to S3 buckets
#   Default: $::os_service_default
#
# [*s3_listen*]
#   IP address for S3 API to listen
#   Default: $::os_service_default
#
# [*s3_listen_port*]
#   Port used when accessing the S3 api
#   Default: $::os_service_default
#
# ==== Image
#
# [*image_decryption_dir*]
#   Parent directory for tempdir used for image decryption.
#   Default: $::os_service_default
#
# [*s3_host*]
#   Hostname or IP for OpenStack to use when accessing the S3.
#   Default: $::os_service_default
#
# [*s3_port*]
#   Port used when accessing the S3 API.
#   Default: $::os_service_default
#
# [*s3_use_ssl*]
#   Whether to use SSL when talking to S3.
#   Default: $::os_service_default
#
# [*s3_affix_tenant*]
#   Whether to affix the tenant id to the access key
#   when downloading from S3.
#   Default: $::os_service_default
#
# [*cert_topic*]
#   The topic cert nodes listen on.
#   Default: $::os_service_default
#
# ==== Manage Service
#
# [*manage_service*]
#   Should the S3 service actually be managed by Puppet?
#   Default: true
#
# [*service_name*]
#   The real system name of the S3 service.
#   Default: $::ec2api::params::s3_service_name
#
# [*enabled*]
#   Should the service be enabled and started (true)
#   or disabled and stopped (false).
#   Default: true
#
class ec2api::s3 (
  # S3 server
  $buckets_path         = $::os_service_default,
  $cert_topic           = $::os_service_default,
  $s3_listen            = $::os_service_default,
  $s3_listen_port       = $::os_service_default,
  # Image
  $image_decryption_dir = $::os_service_default,
  $s3_host              = $::os_service_default,
  $s3_port              = $::os_service_default,
  $s3_use_ssl           = $::os_service_default,
  $s3_affix_tenant      = $::os_service_default,
  # Manage Service
  $manage_service      = true,
  $service_name        = $::ec2api::params::s3_service_name,
  $enabled             = true,
) inherits ::ec2api::params {

  validate_bool($manage_service)
  validate_string($service_name)
  validate_bool($enabled)

  ec2api_config {
    'DEFAULT/buckets_path':         value => $buckets_path;
    'DEFAULT/cert_topic':           value => $cert_topic;
    'DEFAULT/image_decryption_dir': value => $image_decryption_dir;
    'DEFAULT/s3_host':              value => $s3_host;
    'DEFAULT/s3_port':              value => $s3_port;
    'DEFAULT/s3_listen':            value => $s3_listen;
    'DEFAULT/s3_listen_port':       value => $s3_listen_port;
    'DEFAULT/s3_use_ssl':           value => $s3_use_ssl;
    'DEFAULT/s3_affix_tenant':      value => $s3_affix_tenant;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  service { 'openstack-ec2-s3-service' :
    ensure     => $service_ensure,
    name       => $service_name,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => 'ec2api-service',
  }

  Ec2api_config <||> ~>
  Service['openstack-ec2-s3-service']

}
