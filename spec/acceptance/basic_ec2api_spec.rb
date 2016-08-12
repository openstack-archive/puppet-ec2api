require 'spec_helper_acceptance'

describe 'basic ec2api' do

  context 'default parameters' do

    it 'should work with no errors' do
      pp= <<-EOS
      include ::openstack_integration
      include ::openstack_integration::repos
      include ::openstack_integration::rabbitmq
      include ::openstack_integration::mysql
      include ::openstack_integration::keystone

      # Ec2api resources
      class { '::ec2api::keystone::auth':
        password => 'a_big_secret',
      }
      class { '::ec2api::db::mysql':
        password => 'a_big_secret',
      }
      case $::osfamily {
        'Debian': {
          warning('Ec2api is not yet packaged on Ubuntu systems.')
        }
        'RedHat': {
          class { '::ec2api::db':
            database_connection => 'mysql://ec2api:a_big_secret@127.0.0.1/ec2api?charset=utf8',
          }
          class { '::ec2api': }
          class { '::ec2api::keystone::authtoken':
            password => 'a_big_secret',
          }
          class { '::ec2api::api':
            keystone_url => 'http://127.0.0.1:5000/v2',
          }
          include ::ec2api::metadata
        }
      }
      EOS

      # Run it twice to test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

  end
end
