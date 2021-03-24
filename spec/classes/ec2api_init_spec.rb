require 'spec_helper'

describe 'ec2api' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      describe 'with default parameters' do
        let :params do
          { :purge_config => false  }
        end

        it 'passes purge to resource' do
          is_expected.to contain_resources('ec2api_config').with({
            :purge => false
          })
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api') }

        it { is_expected.to contain_class('ec2api::params') }

        it { is_expected.to contain_class('ec2api::deps') }

        it { is_expected.to contain_class('ec2api::config') }

        it { is_expected.to contain_class('ec2api::db') }

        it { is_expected.to contain_class('ec2api::policy') }

        it { is_expected.to contain_package('ec2api') }
      end

    end
  end
end
