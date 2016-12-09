# == Class: ec2api::policy
#
# Configure the ec2api policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for ec2api
#   Example :
#     {
#       'ec2api-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'ec2api-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/ec2api/policy.json
#
class ec2api::policy (
  $policies    = {},
  $policy_path = '/etc/ec2api/policy.json',
) {

  include ::ec2api::deps

  validate_hash($policies)
  validate_absolute_path($policy_path)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'ec2api_config': policy_file => $policy_path }

}
