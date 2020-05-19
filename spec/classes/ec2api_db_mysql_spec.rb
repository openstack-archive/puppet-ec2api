require 'spec_helper'

describe 'ec2api::db::mysql' do
  shared_examples_for 'ec2api::db::mysql' do

    context 'with default parameters' do
      let(:params) do
        {
            password: 'ec2apipass',
        }
      end

      db_parameters = {
          user: 'ec2api',
          password: 'ec2apipass',
          dbname: 'ec2api',
          host: '127.0.0.1',
          charset: 'utf8',
          collate: 'utf8_general_ci',
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('ec2api::db::mysql') }

      it { is_expected.to contain_openstacklib__db__mysql('ec2api').with(db_parameters) }
    end

    context 'with custom parameters' do
      let(:params) do
        {
            password: 'ec2apipass',
            user: 'ec2user',
            dbname: 'ec2db',
            host: '192.168.0.1',
            charset: 'cp1251',
            collate: 'cp1251_general_ci',
            allowed_hosts: %w(192.168.0.2 192.168.0.3),
        }
      end

      db_parameters = {
          user: 'ec2user',
          password: 'ec2apipass',
          dbname: 'ec2db',
          host: '192.168.0.1',
          charset: 'cp1251',
          collate: 'cp1251_general_ci',
          allowed_hosts: %w(192.168.0.2 192.168.0.3)
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('ec2api::db::mysql') }

      it { is_expected.to contain_openstacklib__db__mysql('ec2api').with(db_parameters) }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end 

      it_behaves_like 'ec2api::db::mysql'
    end 
  end
end
