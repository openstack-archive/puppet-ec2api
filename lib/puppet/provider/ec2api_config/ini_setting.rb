Puppet::Type.type(:ec2api_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def self.file_path
    '/etc/ec2api/ec2api.conf'
  end

end
