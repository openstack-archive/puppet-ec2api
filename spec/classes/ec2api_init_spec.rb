require 'spec_helper'

describe 'ec2api' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      describe 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api') }

        it { is_expected.to contain_class('ec2api::params') }

        it { is_expected.to contain_class('ec2api::config') }

        it { is_expected.to contain_class('ec2api::db') }

        it { is_expected.to contain_class('ec2api::policy') }

        it { is_expected.to contain_class('ec2api::logging') }

        it { is_expected.to contain_package('ec2api') }
      end

    end
  end
end
