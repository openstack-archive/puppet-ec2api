require 'spec_helper'

describe 'ec2api::policy' do

  shared_examples_for 'ec2api policies' do
    let :params do
      {
        :policy_path => '/etc/ec2api/policy.yaml',
        :policies    => {
          'context_is_admin' => {
            'key'   => 'context_is_admin',
            'value' => 'foo:bar'
          }
        }
      }
    end

    it 'set up the policies' do
      is_expected.to contain_openstacklib__policy__base('context_is_admin').with({
        :key         => 'context_is_admin',
        :value       => 'foo:bar',
        :file_user   => 'root',
        :file_group  => 'ec2api',
        :file_format => 'yaml',
      })
      is_expected.to contain_oslo__policy('ec2api_config').with(
        :policy_file => '/etc/ec2api/policy.yaml',
      )
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'ec2api policies'
    end
  end
end
