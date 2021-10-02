#
# Unit tests for ec2api::keystone::auth
#

require 'spec_helper'

describe 'ec2api::keystone::auth' do
  shared_examples_for 'ec2api::keystone::auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'ec2api_password' }
      end

      it { is_expected.to contain_keystone__resource__service_identity('ec2api').with(
        :configure_user      => true,
        :configure_user_role => true,
        :configure_endpoint  => true,
        :service_name        => 'ec2api',
        :service_type        => 'ec2api',
        :service_description => 'The EC2 API Service',
        :region              => 'RegionOne',
        :auth_name           => 'ec2api',
        :password            => 'ec2api_password',
        :email               => 'ec2api@localhost',
        :tenant              => 'services',
        :public_url          => 'http://127.0.0.1:8788',
        :internal_url        => 'http://127.0.0.1:8788',
        :admin_url           => 'http://127.0.0.1:8788',
      ) }
    end

    context 'when overriding parameters' do
      let :params do
        { :password            => 'ec2api_password',
          :auth_name           => 'alt_ec2api',
          :email               => 'alt_ec2api@alt_localhost',
          :tenant              => 'alt_service',
          :configure_endpoint  => false,
          :configure_user      => false,
          :configure_user_role => false,
          :service_description => 'Alternative The EC2 API Service',
          :service_name        => 'alt_service',
          :service_type        => 'alt_ec2api',
          :region              => 'RegionTwo',
          :public_url          => 'https://10.10.10.10:80',
          :internal_url        => 'http://10.10.10.11:81',
          :admin_url           => 'http://10.10.10.12:81' }
      end

      it { is_expected.to contain_keystone__resource__service_identity('ec2api').with(
        :configure_user      => false,
        :configure_user_role => false,
        :configure_endpoint  => false,
        :service_name        => 'alt_service',
        :service_type        => 'alt_ec2api',
        :service_description => 'Alternative The EC2 API Service',
        :region              => 'RegionTwo',
        :auth_name           => 'alt_ec2api',
        :password            => 'ec2api_password',
        :email               => 'alt_ec2api@alt_localhost',
        :tenant              => 'alt_service',
        :public_url          => 'https://10.10.10.10:80',
        :internal_url        => 'http://10.10.10.11:81',
        :admin_url           => 'http://10.10.10.12:81',
      ) }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'ec2api::keystone::auth'
    end
  end
end
