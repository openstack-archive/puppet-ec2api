require 'spec_helper'

describe 'ec2api::keystone::auth' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts }

      describe 'with default parameters' do
        let(:params) do
          {
              password: 'my_password',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::keystone::auth') }

        it { is_expected.to contain_class('ec2api::params') }

        it { is_expected.to contain_class('ec2api::deps') }

        it do
          parameters = {
              :configure_user => true,
              :configure_user_role => true,
              :configure_endpoint => true,
              :service_name => 'ec2api',
              :service_type => 'ec2api',
              :service_description => 'The EC2 API Service',
              :region => 'RegionOne',
              :auth_name => 'ec2api',
              :password => 'my_password',
              :email => 'ec2api@localhost',
              :tenant => 'services',
              :public_url => 'http://127.0.0.1:8788',
              :internal_url => 'http://127.0.0.1:8788',
              :admin_url => 'http://127.0.0.1:8788',
          }
          is_expected.to contain_keystone__resource__service_identity('ec2api').with(parameters)
        end
      end

      describe 'with custom parameters' do
        let(:params) do
          {
              password: 'my_password',
              auth_name: 'me',
              email: 'me@localhost',
              tenant: 'my_tenant',
              configure_endpoint: false,
              configure_user: false,
              configure_user_role: false,
              service_name: 'my_service',
              service_description: 'The service',
              service_type: 'my_type',
              region: 'my_region',
              public_url: 'http://192.168.0.1:8788',
              internal_url: 'http://192.168.0.1:8788',
              admin_url: 'http://192.168.0.1:8788',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::keystone::auth') }

        it { is_expected.to contain_class('ec2api::params') }

        it do
          parameters = {
              :configure_user => false,
              :configure_user_role => false,
              :configure_endpoint => false,
              :service_name => 'my_service',
              :service_type => 'my_type',
              :service_description => 'The service',
              :region => 'my_region',
              :auth_name => 'me',
              :password => 'my_password',
              :email => 'me@localhost',
              :tenant => 'my_tenant',
              :public_url => 'http://192.168.0.1:8788',
              :internal_url => 'http://192.168.0.1:8788',
              :admin_url => 'http://192.168.0.1:8788',
          }
          is_expected.to contain_keystone__resource__service_identity('ec2api').with(parameters)
        end
      end

    end
  end
end
