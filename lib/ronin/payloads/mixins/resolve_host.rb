# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# ronin-payloads is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-payloads is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-payloads.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/support/network/dns'

require 'ipaddr'

module Ronin
  module Payloads
    module Mixins
      #
      # Adds methods for resolving the `host` parameter and converting it to
      # IP address(es).
      #
      # @api public
      #
      module ResolveHost
        #
        # Resolves the `host` and returns it's IP addresses.
        #
        # @return [Array<String>]
        #
        def host_addresses
          host = params[:host]

          # check if the `host` value is already an IP address
          if host =~ IPAddr::RE_IPV4ADDRLIKE ||
             host =~ IPAddr::RE_IPV6ADDRLIKE_COMPRESSED ||
             host =~ IPAddr::RE_IPV6ADDRLIKE_FULL
            [host]
          else
            Support::Network::DNS.get_addresses(host)
          end
        end

        #
        # Resolves the `host` parameter and returns the first address.
        #
        # @return [String, nil]
        #
        def host_address
          host_addresses.first
        end

        #
        # Resolves the `host` and returns it's IPv4 and IPv6 addresses.
        #
        # @return [Array<String>]
        #
        def host_ip_addresses
          host = params[:host]

          # check if the `host` value is already an IP address
          if host =~ IPAddr::RE_IPV4ADDRLIKE ||
             host =~ IPAddr::RE_IPV6ADDRLIKE_COMPRESSED ||
             host =~ IPAddr::RE_IPV6ADDRLIKE_FULL
            [host]
          else
            Support::Network::DNS.get_ip_addresses(host)
          end
        end

        #
        # Resolves the `host` parameter and returns the first IPv4 or IPv6
        # address.
        #
        # @return [String, nil]
        #
        def host_ip_address
          host_ip_addresses.first
        end

        #
        # Resolves the `host` parameter and returns the IPv4 addresses.
        #
        # @return [Array<String>]
        #
        def host_ipv4_addresses
          host = params[:host]

          if host =~ IPAddr::RE_IPV4ADDRLIKE
            [host]
          elsif host =~ IPAddr::RE_IPV6ADDRLIKE_COMPRESSED ||
                host =~ IPAddr::RE_IPV6ADDRLIKE_FULL
            raise(ValidationError,"host must be a hostname or an IPv4 address, was an IPv6 address: #{host.inspect}")
          else
            Support::Network::DNS.get_ipv4_addresses(host)
          end
        end

        #
        # Resolves the `host` parameter and returns the first IPv4 address.
        #
        # @return [String, nil]
        #
        def host_ipv4_address
          host_ipv4_addresses.first
        end

        #
        # Resolves the `host` parameter and returns the IPv6 addresses.
        #
        # @return [Array<String>]
        #
        def host_ipv6_addresses
          host = params[:host]

          if host =~ IPAddr::RE_IPV4ADDRLIKE
            ["::ffff:#{host}"]
          elsif host =~ IPAddr::RE_IPV6ADDRLIKE_COMPRESSED ||
                host =~ IPAddr::RE_IPV6ADDRLIKE_FULL
            [host]
          else
            Support::Network::DNS.get_ipv6_addresses(host)
          end
        end

        #
        # Resolves the `host` parameter and returns the first IPv6 address.
        #
        # @return [String, nil]
        #
        def host_ipv6_address
          host_ipv6_addresses.first
        end
      end
    end
  end
end
