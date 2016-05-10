require 'spec_helper'

describe 'ec2api::db' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      describe 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::db') }

        parameters = {
            :connection     => 'sqlite:////var/lib/ec2api/ec2api.sqlite',
            :idle_timeout   => '<SERVICE DEFAULT>',
            :min_pool_size  => '<SERVICE DEFAULT>',
            :max_retries    => '<SERVICE DEFAULT>',
            :retry_interval => '<SERVICE DEFAULT>',
            :max_pool_size  => '<SERVICE DEFAULT>',
            :max_overflow   => '<SERVICE DEFAULT>',
        }

        it { is_expected.to contain_oslo__db('ec2api_config').with(parameters) }
      end

      describe 'with custom parameters' do
        let(:params) do
          {
              :database_connection     => 'sqlite:////path/to/my/db.sqlite',
              :database_idle_timeout   => '1',
              :database_min_pool_size  => '2',
              :database_max_retries    => '3',
              :database_retry_interval => '4',
              :database_max_pool_size  => '5',
              :database_max_overflow   => '6',
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::db') }

        parameters = {
            :connection     => 'sqlite:////path/to/my/db.sqlite',
            :idle_timeout   => '1',
            :min_pool_size  => '2',
            :max_retries    => '3',
            :retry_interval => '4',
            :max_pool_size  => '5',
            :max_overflow   => '6',
        }

        it { is_expected.to contain_oslo__db('ec2api_config').with(parameters) }
      end

    end
  end
end
