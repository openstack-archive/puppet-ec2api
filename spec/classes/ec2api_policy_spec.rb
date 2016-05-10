require 'spec_helper'

describe 'ec2api::policy' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      describe 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::policy') }
      end

      describe 'with custom parameters' do
        let(:params) do
          {
              policies: {},
              policy_path: '/etc/ec2api/policy.json',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::policy') }
      end

    end
  end
end