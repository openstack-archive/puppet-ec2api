require 'spec_helper'

describe 'ec2api' do

  shared_examples 'ec2api' do

    context 'with default parameters' do

      it 'contains other classes' do
        is_expected.to contain_class('ec2api::logging')
        is_expected.to contain_class('ec2api::params')
        is_expected.to contain_class('ec2api::policy')
        is_expected.to contain_class('ec2api::db')
      end

      it 'installs packages' do
        is_expected.to contain_package('ec2api').with(
          :name   => platform_params[:api_package_name],
          :ensure => 'present',
          :tag    => ['openstack', 'ec2api-package']
        )
      end
    end

    context 'with overridden parameters' do
      let :params do
        { :package_ensure => 'latest',
        }
      end

      it 'installs packages' do
        is_expected.to contain_package('ec2api').with(
          :name   => platform_params[:api_package_name],
          :ensure => 'latest',
          :tag    => ['openstack', 'ec2api-package']
        )
      end

    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :api_package_name => 'ec2api', }
        when 'RedHat'
          { :api_package_name => 'openstack-ec2-api', }
        end
      end
      it_configures 'ec2api'
    end
  end
end
