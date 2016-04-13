#
# Unit tests for ec2api::keystone::auth
#

require 'spec_helper'

describe 'ec2api::keystone::auth' do

  let :facts do
    { :osfamily => 'Debian' }
  end

  describe 'with default class parameters' do
    let :params do
      { :password => 'ec2api_password',
        :tenant   => 'services' }
    end

    it { is_expected.to contain_keystone_user('ec2api').with(
      :ensure   => 'present',
      :password => 'ec2api_password',
    ) }

    it { is_expected.to contain_keystone_user_role('ec2api@services').with(
      :ensure  => 'present',
      :roles   => ['admin']
    )}

    it { is_expected.to contain_keystone_service('ec2api::ec2').with(
      :ensure      => 'present',
      :description => 'ec2api Service'
    ) }

    it { is_expected.to contain_keystone_endpoint('RegionOne/ec2api::ec2').with(
      :ensure       => 'present',
      :public_url   => 'http://127.0.0.1:8788',
      :admin_url    => 'http://127.0.0.1:8788',
      :internal_url => 'http://127.0.0.1:8788',
    ) }
  end

  describe 'when overriding URL parameters' do
    let :params do
      { :password     => 'ec2api_password',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81', }
    end

    it { is_expected.to contain_keystone_endpoint('RegionOne/ec2api::ec2').with(
      :ensure       => 'present',
      :public_url   => 'https://10.10.10.10:80',
      :internal_url => 'http://10.10.10.11:81',
      :admin_url    => 'http://10.10.10.12:81',
    ) }
  end

  describe 'when overriding auth name' do
    let :params do
      { :password => 'foo',
        :auth_name => 'ec2api_user' }
    end

    it { is_expected.to contain_keystone_user('ec2api_user') }
    it { is_expected.to contain_keystone_user_role('ec2api_user@services') }
    it { is_expected.to contain_keystone_service('ec2api_user::ec2') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/ec2api_user::ec2') }
  end

  describe 'when overriding service name' do
    let :params do
      { :service_name => 'ec2api_service',
        :auth_name    => 'ec2api',
        :password     => 'ec2api_password' }
    end

    it { is_expected.to contain_keystone_user('ec2api') }
    it { is_expected.to contain_keystone_user_role('ec2api@services') }
    it { is_expected.to contain_keystone_service('ec2api_service::ec2') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/ec2api_service::ec2') }
  end

  describe 'when disabling user configuration' do

    let :params do
      {
        :password       => 'ec2api_password',
        :configure_user => false
      }
    end

    it { is_expected.not_to contain_keystone_user('ec2api') }
    it { is_expected.to contain_keystone_user_role('ec2api@services') }
    it { is_expected.to contain_keystone_service('ec2api::ec2').with(
      :ensure      => 'present',
      :description => 'ec2api Service'
    ) }

  end

  describe 'when disabling user and user role configuration' do

    let :params do
      {
        :password            => 'ec2api_password',
        :configure_user      => false,
        :configure_user_role => false
      }
    end

    it { is_expected.not_to contain_keystone_user('ec2api') }
    it { is_expected.not_to contain_keystone_user_role('ec2api@services') }
    it { is_expected.to contain_keystone_service('ec2api::ec2').with(
      :ensure      => 'present',
      :description => 'ec2api Service'
    ) }

  end

end
