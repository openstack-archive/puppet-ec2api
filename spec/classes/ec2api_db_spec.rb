require 'spec_helper'

describe 'ec2api::db' do
  shared_examples 'ec2api::db' do
    context 'with default parameters' do
      it { should contain_class('ec2api::deps') }

      it { should contain_oslo__db('ec2api_config').with(
        :connection              => 'sqlite:////var/lib/ec2api/ec2api.sqlite',
        :connection_recycle_time => '<SERVICE DEFAULT>',
        :min_pool_size           => '<SERVICE DEFAULT>',
        :db_max_retries          => '<SERVICE DEFAULT>',
        :max_retries             => '<SERVICE DEFAULT>',
        :retry_interval          => '<SERVICE DEFAULT>',
        :max_pool_size           => '<SERVICE DEFAULT>',
        :max_overflow            => '<SERVICE DEFAULT>',
        :pool_timeout            => '<SERVICE DEFAULT>',
      )}
    end

    context 'with specific parameters' do
      let :params do
        {
          :database_connection              => 'sqlite:////path/to/my/db.sqlite',
          :database_connection_recycle_time => '1',
          :database_min_pool_size           => '2',
          :database_db_max_retries          => '-1',
          :database_max_retries             => '3',
          :database_retry_interval          => '4',
          :database_max_pool_size           => '5',
          :database_max_overflow            => '6',
          :database_pool_timeout            => '7',
        }
      end

      it { should contain_class('ec2api::deps') }

      it { should contain_oslo__db('ec2api_config').with(
        :connection              => 'sqlite:////path/to/my/db.sqlite',
        :connection_recycle_time => '1',
        :min_pool_size           => '2',
        :db_max_retries          => '-1',
        :max_retries             => '3',
        :retry_interval          => '4',
        :max_pool_size           => '5',
        :max_overflow            => '6',
        :pool_timeout            => '7',
      )}
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'ec2api::db'
    end
  end
end
