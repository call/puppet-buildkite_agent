# Converts a ruby hash to an xml plist
require 'puppet/util/plist' if Puppet.features.cfpropertylist?

Puppet::Functions.create_function(:hash2plist) do
  dispatch :plist do
    param 'Hash', :hash
  end

  def plist(hash)
    Puppet::Util::Plist.dump_plist(hash)
  end
end
