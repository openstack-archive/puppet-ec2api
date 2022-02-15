Puppet::Type.type(:ec2api_config).provide(
  :openstackconfig,
  :parent => Puppet::Type.type(:openstack_config).provider(:ruby)
) do

  def self.file_path
    '/etc/ec2api/ec2api.conf'
  end

end
