require 'spec_helper'

describe 'ec2api::db::postgresql' do

  let :pre_condition do
    'include postgresql::server'
  end

  let :params do
    {
        :password => 'ec2apipass',
    }
  end

  shared_examples_for 'ec2api::db::postgresql' do
    context 'with only required parameters' do
      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('ec2api::db::postgresql') }

      it { is_expected.to contain_openstacklib__db__postgresql('ec2api').with(
        :user       => 'ec2api',
        :password   => 'ec2apipass',
        :dbname     => 'ec2api',
        :encoding   => nil,
        :privileges => 'ALL',
      )} 
    end
  end

  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          # puppet-postgresql requires the service_provider fact provided by
          # puppetlabs-postgresql.
          :service_provider => 'systemd'
        }))
      end
      it_behaves_like 'ec2api::db::postgresql'
    end
  end

end
