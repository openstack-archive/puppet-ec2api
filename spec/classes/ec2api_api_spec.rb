require 'spec_helper'

describe 'ec2api::api', type: :class do

  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os, facts|
    context "on #{os}" do

      let(:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      config_items = %w(
        DEFAULT/keystone_ec2_tokens_url
        DEFAULT/ec2_timestamp_expiry
        DEFAULT/ec2api_listen
        DEFAULT/ec2api_listen_port
        DEFAULT/ec2api_use_ssl
        DEFAULT/service_down_time
        DEFAULT/api_paste_config
        DEFAULT/ssl_insecure
        ssl/ca_file
        ssl/cert_file
        ssl/key_file
        DEFAULT/tcp_keepidle
        DEFAULT/wsgi_default_pool_size
        DEFAULT/max_header_line
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
        DEFAULT/fatal_exception_format_errors
        DEFAULT/tempdir
        DEFAULT/pybasedir
        DEFAULT/bindir
        DEFAULT/state_path
      )

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::api') }
        it { is_expected.to contain_class('ec2api::deps') }
        it { is_expected.to contain_class('ec2api::params') }

        config_items.each do |item|
          it { is_expected.to contain_ec2api_config(item).with_value('<SERVICE DEFAULT>') }
        end

        it 'configures workers using os_workers' do
          is_expected.to contain_ec2api_config('DEFAULT/ec2api_workers').with_value(2)
        end

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
