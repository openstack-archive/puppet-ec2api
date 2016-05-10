require 'spec_helper'

describe 'ec2api::s3', type: :class do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      config_items = %w(
        DEFAULT/buckets_path
        DEFAULT/cert_topic
        DEFAULT/image_decryption_dir
        DEFAULT/s3_host
        DEFAULT/s3_port
        DEFAULT/s3_listen
        DEFAULT/s3_listen_port
        DEFAULT/s3_use_ssl
        DEFAULT/s3_affix_tenant
      )

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::s3') }

        it { is_expected.to contain_class('ec2api::params') }

        config_items.each do |item|
          it { is_expected.to contain_ec2api_config(item).with_value('<SERVICE DEFAULT>') }
        end

        service_parameters = {
            ensure: 'running',
            enable: true,
        }

        it { is_expected.to contain_service('openstack-ec2-s3-service').with(service_parameters) }
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

        it { is_expected.to contain_service('openstack-ec2-s3-service').with(service_parameters) }
      end

    end
  end
end
