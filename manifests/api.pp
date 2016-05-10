# == Class: ec2api::api
#
# EC2 API class to configure the API service via puppet.
#
# === Parameters
#
# All options are optional unless specified otherwise.
# All options defaults to $::os_service_default and
# the default values from the service are used.
#
# === API
#
# [*keystone_url*]
#   URL for getting admin session.
#   Default: $::os_service_default
#
# [*keystone_ec2_tokens_url*]
#   URL to authenticate token from ec2 request.
#   Default: $::os_service_default
#
# [*ec2_timestamp_expiry*]
#   Time in seconds before ec2 timestamp expires.
#   Default: $::os_service_default
#
# === Service
#
# [*ec2api_listen*]
#   The IP address on which the EC2 API will listen.
#   Default: $::os_service_default
#
# [*ec2api_listen_port*]
#   The port on which the EC2 API will listen.
#   Default: $::os_service_default
#
# [*ec2api_use_ssl*]
#   Enable ssl connections or not for EC2 API.
#   Default: $::os_service_default
#
# [*ec2api_workers*]
#   Number of workers for EC2 API service.
#   The default will be equal to the number of CPUs available.
#   Default: $::os_service_default
#
# [*service_down_time*]
#   Maximum time since last check-in for up service.
#   Default: $::os_service_default
#
# === Keystone
#
# [*delay_auth_decision*]
#   Do not handle authorization requests within the middleware, but delegate
#   the authorization decision to downstream WSGI components
#   Default: $::os_service_default
#
# [*http_connect_timeout*]
#   Request timeout value for communicating with Identity API server
#   Default: $::os_service_default
#
# [*http_request_max_retries*]
#   How many times are we trying to reconnect when communicating with Identity API Server.
#   Default: $::os_service_default
#
# [*keystone_admin_user*]
#   Keystone account username
#   Default: $::os_service_default
#
# [*keystone_admin_password*]
#   (Required) Keystone account password
#
# [*keystone_admin_tenant_name*]
#   Keystone service account tenant name to validate user tokens
#   Default: $::os_service_default
#
# [*insecure*]
#   Verify HTTPS connections
#   Default: $::os_service_default
#
# [*signing_dir*]
#   Directory used to cache files related to PKI tokens
#   Default: $::os_service_default
#
# [*memcached_servers*]
#   Optionally specify a list of memcached server(s) to use for caching. If
#   left undefined, tokens will instead be cached in-process.
#   Default: $::os_service_default
#
# [*token_cache_time*]
#   In order to prevent excessive effort spent validating tokens, the
#   middleware caches previously-seen tokens for a configurable duration
#   (in seconds). Set to -1 to disable caching completely
#   Default: $::os_service_default
#
# [*cache_time*]
#   Time to cache the revocation list and the revocation
#   events (in seconds). This has no effect unless
#   global and token caching are enabled.
#   Default: $::os_service_default
#
# [*memcache_security_strategy*]
#   (Optional) Indicates whether token data should be
#   authenticated or authenticated and encrypted. Acceptable values are MAC
#   or ENCRYPT.  If MAC, token data is authenticated (with HMAC) in the
#   cache. If ENCRYPT, token data is encrypted and authenticated in the
#   cache. If the value is not one of these options or empty, auth_token will
#   raise an exception on initialization
#   Default: $::os_service_default
#
# [*memcache_secret_key*]
#   (Required if memcache_security_strategy is defined) this string
#   is used for key derivation
#   Default: $::os_service_default
#
# [*include_service_catalog*]
#   (Optional) Indicates whether to set the X-Service-Catalog header. If False,
#   middleware will not ask for service catalog on token validation and
#   will not set the X-Service-Catalog header
#   Default: $::os_service_default
#
# [*enforce_token_bind*]
#   Used to control the use and type of token binding. Can be  set to:
#   "disabled" to not check token binding. "permissive" (default) to
#   validate binding information if the bind type is of a form known to the
#   server and ignore it if not. "strict" like "permissive" but if the bind
#   type is unknown the token will be rejected. "required" any form of token
#   binding is needed to be allowed. Finally the name of a binding method that
#   must be present in tokens
#   Default: $::os_service_default
#
# [*check_revocations_for_cached*]
#   Used to control the use and type of token binding. Can be set to:
#   "disabled" to not check token binding. "permissive" (default) to validate
#   binding information if the bind type is of a form known to the server and
#   ignore it if not. "strict" like "permissive" but if the bind type is
#   unknown the token will be rejected. "required" any form of token binding
#   is needed to be allowed. Finally the name of a  binding method that must
#   be present in tokens
#   Default: $::os_service_default
#
# [*hash_algorithms*]
#   Hash algorithms to use for hashing PKI tokens. This may be a single
#   algorithm or multiple. The algorithms are those supported by Python
#   standard hashlib.new(). The hashes will be tried in the order given, so
#   put the preferred one first for performance. The result of the first hash
#   will be stored in the cache. This will typically be set to multiple values
#   only while migrating from a less secure algorithm to a more secure one.
#   Once all the old tokens are expired this option should be set to a single
#   value for better performance
#   Default: $::os_service_default
#
# [*keystone_certfile*]
#   Required if Keystone server requires client certificate
#   Default: $::os_service_default
#
# [*keystone_keyfile*]
#   Required if Keystone server requires client certificate
#   Default: $::os_service_default
#
# [*keystone_cafile*]
#   A PEM encoded Certificate Authority to use when verifying HTTPs
#   connections. Defaults to system CAs.
#   Default: $::os_service_default
#
# === WSGI
#
# [*api_paste_config*]
#   File name for the paste.deploy config for ec2api.
#   Default: $::os_service_default
#
# [*ssl_cert_file*]
#   SSL certificate of API server.
#   Default: $::os_service_default
#
# [*ssl_key_file*]
#   SSL private key of API server.
#   Default: $::os_service_default
#
# [*tcp_keepidle*]
#   Sets the value of TCP_KEEPIDLE in seconds for each
#   server socket. Not supported on OS X.
#   Default: $::os_service_default
#
# [*wsgi_default_pool_size*]
#   Size of the pool of greenthreads used by wsgi.
#   Default: $::os_service_default
#
# [*max_header_line*]
#   Maximum line size of message headers to be accepted.
#   max_header_line may need to be increased when using
#   large tokens (typically those generated by the
#   Keystone v3 API with big service catalogs).
#   Default: $::os_service_default
#
# === API clients
#
# [*ssl_insecure*]
#   Verify HTTPS connections.
#   Default: $::os_service_default
#
# [*ssl_ca_file*]
#   VCA certificate file to use to verify connecting clients.
#   Default: $::os_service_default
#
# [*nova_service_type*]
#   Service type of Compute API, registered in Keystone
#   catalog. Should be v2.1 with microversion support.
#   If it is obsolete v2, a lot of useful EC2 compliant
#   instance properties will be unavailable.
#   Default: $::os_service_default
#
# [*cinder_service_type*]
#   Service type of Volume API, registered in Keystone catalog.
#   Default: $::os_service_default
#
# [*admin_user*]
#   Admin user to access specific cloud resourses.
#   Default: $::os_service_default
#
# [*admin_password*]
#   Admin password.
#   Default: $::os_service_default
#
# [*admin_tenant_name*]
#   Admin tenant name.
#   Default: $::os_service_default
#
# === Auth
#
# [*api_rate_limit*]
#   Whether to use per-user rate limiting for the API.
#   Default: $::os_service_default
#
# [*use_forwarded_for*]
#   Treat X-Forwarded-For as the canonical remote address.
#   Only enable this if you have a sanitizing proxy.
#   Default: $::os_service_default
#
# === ec2utils
#
# [*external_network*]
#   Name of the external network, which is used to connect VPCs to
#   Internet and to allocate Elastic IPs.
#   Default: $::os_service_default
#
# === Availability zone
#
# [*internal_service_availability_zone*]
#   The availability_zone to show internal services under.
#   Default: $::os_service_default
#
# [*my_ip*]
#   IP address of this host.
#   Default: $::os_service_default
#
# [*ec2_host*]
#   The IP address of the EC2 API server.
#   Default: $::os_service_default
#
# [*ec2_port*]
#   The port of the EC2 API server.
#   Default: $::os_service_default
#
# [*ec2_scheme*]
#   The protocol to use when connecting to the EC2 API server (http, https).
#   Default: $::os_service_default
#
# [*ec2_path*]
#   The path prefix used to call the ec2 API server.
#   Default: $::os_service_default
#
# [*region_list*]
#   List of region=fqdn pairs separated by commas.
#   Default: $::os_service_default
#
# === DHCP options
#
# [*network_device_mtu*]
#   MTU size to set by DHCP for instances.
#   Corresponds with the network_device_mtu in ec2api.conf.
#   Default: $::os_service_default
#
# === Common
#
# [*full_vpc_support*]
#   True if server supports Neutron for full VPC access.
#   Default: $::os_service_default
#
# === Instance
#
# [*ec2_private_dns_show_ip*]
#   Return the IP address as private dns hostname in describe instances
#   Default: $::os_service_default
#
# [*default_flavor*]
#   A flavor to use as a default instance type
#   Default: $::os_service_default
#
# === DB
#
# [*use_tpool*]
#   Enable the experimental use of thread pooling for
#   all DB API calls
#   Default: $::os_service_default
#
# === Exception
#
# [*fatal_exception_format_errors*]
#   Make exception message format errors fatal.
#   Default: $::os_service_default
#
# === Paths
#
# [*tempdir*]
#   Explicitly specify the temporary working directory.
#   Default: $::os_service_default
#
# [*pybasedir*]
#   Directory where the ec2api python module is installed.
#   Default: $::os_service_default
#
# [*bindir*]
#   Directory where ec2api binaries are installed.
#   Default: $::os_service_default
#
# [*state_path*]
#   Top-level directory for maintaining ec2api's state.
#   Default: $::os_service_default
#
# === Manage service
#
# [*manage_service*]
#   Should the API service actually be managed by Puppet?
#   Default: true
#
# [*service_name*]
#   The real system name of the API service.
#   Default: $::ec2api::params::api_service_name
#
# [*enabled*]
#   Should the service be enabled and started (true) of disabled and stopped (false).
#   Default: true
#
# [*debug*]
#   Show debug messages
#   Default: $::os_service_default
#
class ec2api::api (
  # API
  $keystone_url                       = $::os_service_default,
  $keystone_ec2_tokens_url            = $::os_service_default,
  $ec2_timestamp_expiry               = $::os_service_default,
  # Service
  $ec2api_listen                      = $::os_service_default,
  $ec2api_listen_port                 = $::os_service_default,
  $ec2api_use_ssl                     = $::os_service_default,
  $ec2api_workers                     = $::os_service_default,
  $service_down_time                  = $::os_service_default,
  # Keystone
  $delay_auth_decision                = $::os_service_default,
  $http_connect_timeout               = $::os_service_default,
  $http_request_max_retries           = $::os_service_default,
  $keystone_admin_user                = $::os_service_default,
  $keystone_admin_password,
  $keystone_admin_tenant_name         = $::os_service_default,
  $insecure                           = $::os_service_default,
  $signing_dir                        = $::os_service_default,
  $token_cache_time                   = $::os_service_default,
  $cache_time                         = $::os_service_default,
  $memcached_servers                  = $::os_service_default,
  $memcache_security_strategy         = $::os_service_default,
  $memcache_secret_key                = $::os_service_default,
  $include_service_catalog            = $::os_service_default,
  $enforce_token_bind                 = $::os_service_default,
  $check_revocations_for_cached       = $::os_service_default,
  $hash_algorithms                    = $::os_service_default,
  $keystone_certfile                  = $::os_service_default,
  $keystone_keyfile                   = $::os_service_default,
  $keystone_cafile                    = $::os_service_default,
  # WSGI
  $api_paste_config                   = $::os_service_default,
  $ssl_cert_file                      = $::os_service_default,
  $ssl_key_file                       = $::os_service_default,
  $tcp_keepidle                       = $::os_service_default,
  $wsgi_default_pool_size             = $::os_service_default,
  $max_header_line                    = $::os_service_default,
  # API clients
  $ssl_insecure                       = $::os_service_default,
  $ssl_ca_file                        = $::os_service_default,
  $nova_service_type                  = $::os_service_default,
  $cinder_service_type                = $::os_service_default,
  $admin_user                         = $::os_service_default,
  $admin_password                     = $::os_service_default,
  $admin_tenant_name                  = $::os_service_default,
  # auth
  $api_rate_limit                     = $::os_service_default,
  $use_forwarded_for                  = $::os_service_default,
  # ec2utils
  $external_network                   = $::os_service_default,
  # Availability zone
  $internal_service_availability_zone = $::os_service_default,
  $my_ip                              = $::os_service_default,
  $ec2_host                           = $::os_service_default,
  $ec2_port                           = $::os_service_default,
  $ec2_scheme                         = $::os_service_default,
  $ec2_path                           = $::os_service_default,
  $region_list                        = $::os_service_default,
  # DHCP options
  $network_device_mtu                 = $::os_service_default,
  # Common
  $full_vpc_support                   = $::os_service_default,
  # Instance
  $ec2_private_dns_show_ip            = $::os_service_default,
  $default_flavor                     = $::os_service_default,
  # DB
  $use_tpool                          = $::os_service_default,
  # Exception
  $fatal_exception_format_errors      = $::os_service_default,
  # Paths
  $tempdir                            = $::os_service_default,
  $pybasedir                          = $::os_service_default,
  $bindir                             = $::os_service_default,
  $state_path                         = $::os_service_default,
  # Manage service
  $manage_service                     = true,
  $service_name                       = $::ec2api::params::api_service_name,
  $enabled                            = true,
  # Debug
  $debug                              = $::os_service_default,
) inherits ::ec2api::params {

  validate_bool($manage_service)
  validate_string($service_name)
  validate_bool($enabled)

  ec2api_config {
    'DEFAULT/keystone_url':                            value => $keystone_url;
    'DEFAULT/keystone_ec2_tokens_url':                 value => $keystone_ec2_tokens_url;
    'DEFAULT/ec2_timestamp_expiry':                    value => $ec2_timestamp_expiry;
    'DEFAULT/ec2api_listen':                           value => $ec2api_listen;
    'DEFAULT/ec2api_listen_port':                      value => $ec2api_listen_port;
    'DEFAULT/ec2api_use_ssl':                          value => $ec2api_use_ssl;
    'DEFAULT/ec2api_workers':                          value => $ec2api_workers;
    'DEFAULT/service_down_time':                       value => $service_down_time;
    'keystone_authtoken/delay_auth_decision':          value => $delay_auth_decision;
    'keystone_authtoken/http_connect_timeout':         value => $http_connect_timeout;
    'keystone_authtoken/http_request_max_retries':     value => $http_request_max_retries;
    'keystone_authtoken/admin_user':                   value => $keystone_admin_user;
    'keystone_authtoken/admin_password':               value => $keystone_admin_password;
    'keystone_authtoken/admin_tenant':                 value => $keystone_admin_tenant_name;
    'keystone_authtoken/insecure':                     value => $insecure;
    'keystone_authtoken/signing_dir':                  value => $signing_dir;
    'keystone_authtoken/token_cache_time':             value => $token_cache_time;
    'keystone_authtoken/cache_time':                   value => $cache_time;
    'keystone_authtoken/memcached_servers':            value => $memcached_servers;
    'keystone_authtoken/memcache_security_strategy':   value => $memcache_security_strategy;
    'keystone_authtoken/memcache_secret_key':          value => $memcache_secret_key;
    'keystone_authtoken/include_service_catalog':      value => $include_service_catalog;
    'keystone_authtoken/enforce_token_bind':           value => $enforce_token_bind;
    'keystone_authtoken/check_revocations_for_cached': value => $check_revocations_for_cached;
    'keystone_authtoken/hash_algorithms':              value => $hash_algorithms;
    'keystone_authtoken/certfile':                     value => $keystone_certfile;
    'keystone_authtoken/keyfile':                      value => $keystone_keyfile;
    'keystone_authtoken/cafile':                       value => $keystone_cafile;
    'DEFAULT/api_paste_config':                        value => $api_paste_config;
    'DEFAULT/ssl_cert_file':                           value => $ssl_cert_file;
    'DEFAULT/ssl_key_file':                            value => $ssl_key_file;
    'DEFAULT/tcp_keepidle':                            value => $tcp_keepidle;
    'DEFAULT/wsgi_default_pool_size':                  value => $wsgi_default_pool_size;
    'DEFAULT/max_header_line':                         value => $max_header_line;
    'DEFAULT/ssl_insecure':                            value => $ssl_insecure;
    'DEFAULT/ssl_ca_file':                             value => $ssl_ca_file;
    'DEFAULT/nova_service_type':                       value => $nova_service_type;
    'DEFAULT/cinder_service_type':                     value => $cinder_service_type;
    'DEFAULT/admin_user':                              value => $admin_user;
    'DEFAULT/admin_password':                          value => $admin_password;
    'DEFAULT/admin_tenant_name':                       value => $admin_tenant_name;
    'DEFAULT/api_rate_limit':                          value => $api_rate_limit;
    'DEFAULT/use_forwarded_for':                       value => $use_forwarded_for;
    'DEFAULT/external_network':                        value => $external_network;
    'DEFAULT/internal_service_availability_zone':      value => $internal_service_availability_zone;
    'DEFAULT/my_ip':                                   value => $my_ip;
    'DEFAULT/ec2_host':                                value => $ec2_host;
    'DEFAULT/ec2_port':                                value => $ec2_port;
    'DEFAULT/ec2_scheme':                              value => $ec2_scheme;
    'DEFAULT/ec2_path':                                value => $ec2_path;
    'DEFAULT/region_list':                             value => $region_list;
    'DEFAULT/network_device_mtu':                      value => $network_device_mtu;
    'DEFAULT/full_vpc_support':                        value => $full_vpc_support;
    'DEFAULT/ec2_private_dns_show_ip':                 value => $ec2_private_dns_show_ip;
    'DEFAULT/default_flavor':                          value => $default_flavor;
    'DEFAULT/use_tpool':                               value => $use_tpool;
    'DEFAULT/fatal_exception_format_errors':           value => $fatal_exception_format_errors;
    'DEFAULT/tempdir':                                 value => $tempdir;
    'DEFAULT/pybasedir':                               value => $pybasedir;
    'DEFAULT/bindir':                                  value => $bindir;
    'DEFAULT/state_path':                              value => $state_path;
    'DEFAULT/debug':                                   value => $debug;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  service { 'openstack-ec2-api-service' :
    ensure     => $service_ensure,
    name       => $service_name,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => 'ec2api-service',
  }

  Ec2api_config <||> ~>
  Service['openstack-ec2-api-service']

}
