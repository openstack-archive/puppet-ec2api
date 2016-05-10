require 'spec_helper'

describe 'ec2api::db::mysql' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os,facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      describe 'with default parameters' do
        let(:params) do
          {
              password: 'my_password',
          }
        end

        db_parameters = {
            user: 'ec2api',
            password_hash: '*CCD3A959D6A004B9C3807B728BC2E55B67E10518',
            dbname: 'ec2api',
            host: '127.0.0.1',
            charset: 'utf8',
            collate: 'utf8_general_ci',
        }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::db::mysql') }

        it { is_expected.to contain_openstacklib__db__mysql('ec2api').with(db_parameters) }
      end

      describe 'with custom parameters' do
        let(:params) do
          {
              password: 'my_password',
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
            password_hash: '*CCD3A959D6A004B9C3807B728BC2E55B67E10518',
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
  end
end
