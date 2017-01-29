# Fact that sucks down all the metadata offered by Digital Ocean other
# than the user data (see note below).
#
# Based on the code written for AWS/EC2 facts that was later merged into
# mainline facter, credit:
# http://projects.puppetlabs.com/projects/1/wiki/Amazon_Ec2_Patterns


require 'open-uri'
require 'timeout'

def metadata(id = "")
  open("http://169.254.169.254/metadata/v1/#{id||=''}").read.
    split("\n").each do |o|
    key = "#{id}#{o.gsub(/\=.*$/, '/')}"
    if key[-1..-1] != '/'
      value = open("http://169.254.169.254/metadata/v1/#{key}").read.
        split("\n")
      value = value.size>1 ? value : value.first
      symbol = "digital_ocean_#{key.gsub(/\-|\//, '_')}".to_sym
  
      # We exclude the user data. This is intentional, the user data often has a
      # bad habit of triggering issues inside Facter due to bad parsing once saved into
      # YAML files and is best left out. You can always pull it on demand/as needed
      # with curl http://169.254.169.254/metadata/v1/user-data if you ever do need it
      unless key == "user-data"
        Facter.add(symbol) { setcode { value } }
      end

    else
      metadata(key)
    end
  end
end

begin
  Timeout::timeout(1) { metadata }
rescue Exception => exc
  Facter.debug "Digital Ocean Metadata Unavailable: #{exc.message}"
end

# vim: ai ts=2 sts=2 et sw=2 ft=ruby
