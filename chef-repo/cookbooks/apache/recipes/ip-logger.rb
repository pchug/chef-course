search("node", "platform:centos").each do |svr|
  log "Centos servers in this org: #{svr['fqdn']} (#{svr['cpu']['0']['mhz']}mhz)"
end
