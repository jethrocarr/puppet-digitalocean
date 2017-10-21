# puppet-digitalocean

Provides a small fact for exposing Digital Ocean metdata (https://developers.digitalocean.com/documentation/metadata/).

Include this module on any Digital Ocean instance and it will expose a number of metrics including:

* digital_ocean_dns_nameservers
* digital_ocean_hostname
* digital_ocean_id
* digital_ocean_interfaces_public_0_ipv4_address
* digital_ocean_interfaces_public_0_ipv4_gateway
* digital_ocean_interfaces_public_0_ipv4_netmask
* digital_ocean_interfaces_public_0_ipv6_address
* digital_ocean_interfaces_public_0_ipv6_cidr
* digital_ocean_interfaces_public_0_ipv6_gateway
* digital_ocean_interfaces_public_0_mac
* digital_ocean_interfaces_public_0_type
* digital_ocean_public_keys
* digital_ocean_region
* digital_ocean_tags


# Usage

These are the same as any other fact, you can simply read them with $::name, eg:

    if ($::digital_ocean_id) {
      notify { "You are running on digital ocean in region: ${::digital_ocean_region}": }
    }


# Troubleshooting

If the fact doesn't work for some reason, run with `facter --debug` to get any
errors being thrown.

