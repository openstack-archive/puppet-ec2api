require 'spec_helper'

describe 'ec2api::db::postgresql' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          :processorcount => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      context 'with only required parameters' do
        let :params do
          {
              :password => 'pw',
          }
        end

        let :pre_condition do
          'include postgresql::server'
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::db::postgresql') }

        it { is_expected.to contain_postgresql__server__db('ec2api').with(
            :user     => 'ec2api',
            :password => 'md58f5ac3d04c0da5a38f9c80d62f00eb1e'
        )}
      end

    end
  end
end
