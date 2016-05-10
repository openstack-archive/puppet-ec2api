require 'spec_helper'

describe 'ec2api::logging' do
  on_supported_os(supported_os: OSDefaults.get_supported_os).each do |os, facts|
    context "on #{os}" do

      let(:facts) { facts.merge! @default_facts }

      describe 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('ec2api::logging') }

        parameters = {
            :use_stderr => '<SERVICE DEFAULT>',
            :use_syslog => '<SERVICE DEFAULT>',
            :log_dir => '/var/log/ec2api',
            :log_file => '/var/log/ec2api/ec2api.log',
            :debug => '<SERVICE DEFAULT>',
            :logging_context_format_string => '<SERVICE DEFAULT>',
            :logging_default_format_string => '<SERVICE DEFAULT>',
            :logging_debug_format_suffix => '<SERVICE DEFAULT>',
            :logging_exception_prefix => '<SERVICE DEFAULT>',
            :log_config_append => '<SERVICE DEFAULT>',
            :default_log_levels => '<SERVICE DEFAULT>',
            :publish_errors => '<SERVICE DEFAULT>',
            :fatal_deprecations => '<SERVICE DEFAULT>',
            :instance_format => '<SERVICE DEFAULT>',
            :instance_uuid_format => '<SERVICE DEFAULT>',
            :log_date_format => '<SERVICE DEFAULT>',
            :syslog_log_facility => '<SERVICE DEFAULT>',
            :watch_log_file => '<SERVICE DEFAULT>',
            :logging_user_identity_format => '<SERVICE DEFAULT>',
        }

        it { is_expected.to contain_oslo__log('ec2api_config').with(parameters) }
      end

    end
  end
end
