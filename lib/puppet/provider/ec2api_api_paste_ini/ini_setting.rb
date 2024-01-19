Puppet::Type.type(:ec2api_api_paste_ini).provide(
    :ini_setting,
    :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def self.file_path
    '/etc/ec2api/api-paste.ini'
  end

end
