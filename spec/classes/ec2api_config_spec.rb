require 'spec_helper'

describe 'ec2api::config' do
  let :params do
    {
      :ec2api_config        => {
        'DEFAULT/foo' => { 'value'  => 'fooValue' },
        'DEFAULT/bar' => { 'value'  => 'barValue' },
        'DEFAULT/baz' => { 'ensure' => 'absent' }
      },
      :ec2api_api_paste_ini => {
        'DEFAULT/foo2' => { 'value'  => 'fooValue' },
        'DEFAULT/bar2' => { 'value'  => 'barValue' },
        'DEFAULT/baz2' => { 'ensure' => 'absent' }
      }
    }
  end

  shared_examples 'ec2api::config' do
    it { should contain_class('ec2api::deps') }

    it {
      should contain_ec2api_config('DEFAULT/foo').with_value('fooValue')
      should contain_ec2api_config('DEFAULT/bar').with_value('barValue')
      should contain_ec2api_config('DEFAULT/baz').with_ensure('absent')
    }

    it {
      should contain_ec2api_api_paste_ini('DEFAULT/foo2').with_value('fooValue')
      should contain_ec2api_api_paste_ini('DEFAULT/bar2').with_value('barValue')
      should contain_ec2api_api_paste_ini('DEFAULT/baz2').with_ensure('absent')
    }
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'ec2api::config'
    end
  end
end
