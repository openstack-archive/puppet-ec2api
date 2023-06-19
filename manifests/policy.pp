# == Class: ec2api::policy
#
# Configure the ec2api policies
#
# === Parameters
#
# [*enforce_scope*]
#  (Optional) Whether or not to enforce scope when evaluating policies.
#  Defaults to $facts['os_service_default'].
#
# [*enforce_new_defaults*]
#  (Optional) Whether or not to use old deprecated defaults when evaluating
#  policies.
#  Defaults to $facts['os_service_default'].
#
# [*policies*]
#   (Optional) Set of policies to configure for ec2api
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
#   (Optional) Path to the ec2api policy.yaml file
#   Defaults to /etc/ec2api/policy.yaml
#
# [*policy_default_rule*]
#   (Optional) Default rule. Enforced when a requested rule is not found.
#   Defaults to $facts['os_service_default'].
#
# [*policy_dirs*]
#   (Optional) Path to the ec2api policy folder
#   Defaults to $facts['os_service_default']
#
# [*purge_config*]
#   (optional) Whether to set only the specified policy rules in the policy
#    file.
#    Defaults to false.
#
class ec2api::policy (
  $enforce_scope        = $facts['os_service_default'],
  $enforce_new_defaults = $facts['os_service_default'],
  Hash $policies        = {},
  $policy_path          = '/etc/ec2api/policy.yaml',
  $policy_default_rule  = $facts['os_service_default'],
  $policy_dirs          = $facts['os_service_default'],
  $purge_config         = false,
) {

  include ec2api::deps
  include ec2api::params

  $policy_parameters = {
    policies     => $policies,
    policy_path  => $policy_path,
    file_user    => 'root',
    file_group   => $::ec2api::params::group,
    file_format  => 'yaml',
    purge_config => $purge_config,
  }

  create_resources('openstacklib::policy', { $policy_path => $policy_parameters })

  oslo::policy { 'ec2api_config':
    enforce_scope        => $enforce_scope,
    enforce_new_defaults => $enforce_new_defaults,
    policy_file          => $policy_path,
    policy_default_rule  => $policy_default_rule,
    policy_dirs          => $policy_dirs,
  }

}
