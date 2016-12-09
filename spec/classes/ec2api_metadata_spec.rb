require 'spec_helper'

describe 'ec2api::metadata', type: :class do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      config_items = %w(
        metadata/nova_metadata_ip
        metadata/nova_metadata_port
        metadata/nova_metadata_protocol
        metadata/nova_metadata_insecure
        metadata/auth_ca_cert
        metadata/nova_client_cert
        metadata/nova_client_priv_key
        metadata/metadata_proxy_shared_secret
        DEFAULT/metadata_listen
        DEFAULT/metadata_listen_port
        DEFAULT/metadata_use_ssl
      )

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::metadata') }

        it { is_expected.to contain_class('ec2api::deps') }

        it { is_expected.to contain_class('ec2api::params') }

        config_items.each do |item|
          it { is_expected.to contain_ec2api_config(item).with_value('<SERVICE DEFAULT>') }
        end

        it 'configures workers using os_workers' do
          is_expected.to contain_ec2api_config('DEFAULT/metadata_workers').with_value(2)
        end

        service_parameters = {
            ensure: 'running',
            enable: true,
        }

        it { is_expected.to contain_service('openstack-ec2-metadata-service').with(service_parameters) }
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

        it { is_expected.to contain_service('openstack-ec2-metadata-service').with(service_parameters) }
      end

    end
  end
end
