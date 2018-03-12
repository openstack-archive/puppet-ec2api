require 'spec_helper'

describe 'ec2api::db::sync' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts }

      describe 'with default parameters' do
        exec_parameters = {
          :command     => 'ec2-api-manage db_sync',
          :path        =>'/usr/bin',
          :user        => 'ec2api',
          :group       => 'ec2api',
          :refreshonly => true,
          :logoutput   => 'on_failure',
          :subscribe   => [
            'Anchor[ec2api::install::end]',
            'Anchor[ec2api::config::end]',
            'Anchor[ec2api::dbsync::begin]'
          ],
          :notify      => 'Anchor[ec2api::dbsync::end]',
          :tag         => 'openstack-db',
        }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::db::sync') }

        it { is_expected.to contain_class('ec2api::params') }

        it { is_expected.to contain_class('ec2api::deps') }

        it { is_expected.to contain_exec('ec2api_db_sync').with(exec_parameters) }
      end

    end
  end
end
