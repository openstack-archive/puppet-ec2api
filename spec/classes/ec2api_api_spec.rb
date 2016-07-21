require 'spec_helper'

describe 'ec2api::api', type: :class do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os, facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      let(:params) do
        {
            password: 'my_password',
        }
      end

      config_items = %w(
        DEFAULT/keystone_url
        DEFAULT/keystone_ec2_tokens_url
        DEFAULT/ec2_timestamp_expiry
        DEFAULT/ec2api_listen
        DEFAULT/ec2api_listen_port
        DEFAULT/ec2api_use_ssl
        DEFAULT/ec2api_workers
        DEFAULT/service_down_time
        DEFAULT/api_paste_config
        DEFAULT/ssl_cert_file
        DEFAULT/ssl_key_file
        DEFAULT/tcp_keepidle
        DEFAULT/wsgi_default_pool_size
        DEFAULT/max_header_line
        DEFAULT/ssl_insecure
        DEFAULT/ssl_ca_file
        DEFAULT/nova_service_type
        DEFAULT/cinder_service_type
        DEFAULT/admin_user
        DEFAULT/admin_password
        DEFAULT/admin_tenant_name
        DEFAULT/api_rate_limit
        DEFAULT/use_forwarded_for
        DEFAULT/external_network
        DEFAULT/internal_service_availability_zone
        DEFAULT/my_ip
        DEFAULT/ec2_host
        DEFAULT/ec2_port
        DEFAULT/ec2_scheme
        DEFAULT/ec2_path
        DEFAULT/region_list
        DEFAULT/network_device_mtu
        DEFAULT/full_vpc_support
        DEFAULT/ec2_private_dns_show_ip
        DEFAULT/default_flavor
        DEFAULT/use_tpool
        DEFAULT/fatal_exception_format_errors
        DEFAULT/tempdir
        DEFAULT/pybasedir
        DEFAULT/bindir
        DEFAULT/state_path
        DEFAULT/debug
        keystone_authtoken/auth_version
        keystone_authtoken/auth_section
        keystone_authtoken/user_domain_name
        keystone_authtoken/project_domain_name
        keystone_authtoken/insecure
        keystone_authtoken/cache
        keystone_authtoken/cafile
        keystone_authtoken/certfile
        keystone_authtoken/check_revocations_for_cached
        keystone_authtoken/delay_auth_decision
        keystone_authtoken/enforce_token_bind
        keystone_authtoken/hash_algorithms
        keystone_authtoken/http_connect_timeout
        keystone_authtoken/http_request_max_retries
        keystone_authtoken/include_service_catalog
        keystone_authtoken/keyfile
        keystone_authtoken/memcache_pool_conn_get_timeout
        keystone_authtoken/memcache_pool_dead_retry
        keystone_authtoken/memcache_pool_maxsize
        keystone_authtoken/memcache_pool_socket_timeout
        keystone_authtoken/memcache_secret_key
        keystone_authtoken/memcache_security_strategy
        keystone_authtoken/memcache_use_advanced_pool
        keystone_authtoken/memcache_pool_unused_timeout
        keystone_authtoken/memcached_servers
        keystone_authtoken/region_name
        keystone_authtoken/revocation_cache_time
        keystone_authtoken/signing_dir
        keystone_authtoken/token_cache_time
      )

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::api') }

        it { is_expected.to contain_class('ec2api::params') }

        config_items.each do |item|
          it { is_expected.to contain_ec2api_config(item).with_value('<SERVICE DEFAULT>') }
        end

        it { is_expected.to contain_ec2api_config('keystone_authtoken/password').with_value('my_password') }
        it { is_expected.to contain_ec2api_config('keystone_authtoken/username').with_value('ec2api') }
        it { is_expected.to contain_ec2api_config('keystone_authtoken/project_name').with_value('services') }
        it {is_expected.to contain_ec2api_config('keystone_authtoken/auth_url').with_value('http://localhost:35357/') }
        it { is_expected.to contain_ec2api_config('keystone_authtoken/auth_uri').with_value('http://localhost:5000/') }
        it { is_expected.to contain_ec2api_config('keystone_authtoken/auth_type').with_value('password') }

        service_parameters = {
            ensure: 'running',
            enable: true,
        }

        it { is_expected.to contain_service('openstack-ec2-api-service').with(service_parameters) }
      end

      context 'with non-default service parameters' do
        let(:params) do
          {
              manage_service: true,
              service_name: 'my-api-service',
              enabled: false,
              password: 'my_password',
          }
        end

        service_parameters = {
            ensure: 'stopped',
            enable: false,
            name: 'my-api-service',
        }

        it { is_expected.to contain_service('openstack-ec2-api-service').with(service_parameters) }
      end

    end
  end
end
