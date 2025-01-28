# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ipaddr'

module Ronin
  module Payloads
    module Mixins
      #
      # Base class for all reverse shell shellcode payloads.
      #
      # @api public
      #
      module Network
        #
        # Packs the IPv4 address in network byte-order.
        #
        # @param [String] ip
        #   The IPv4 address to pack.
        #
        # @param [Boolean] negate
        #   Inverts the bits of the IP address.
        #
        # @return [String]
        #   The packed IP address in network byte-order.
        #
        # @raise [ArgumentError]
        #   The given IP address was not an IPv4 address.
        #
        def pack_ipv4(ip, negate: false)
          ipaddr = IPAddr.new(ip)

          unless ipaddr.ipv4?
            raise(ArgumentError,"IP must be an IPv4 address: #{ip.inspect}")
          end

          ipaddr = ~ipaddr if negate
          ipaddr.hton
        end

        #
        # Packs the IPv6 address in network byte-order.
        #
        # @param [String] ip
        #   The IPv6 address to pack.
        #
        # @param [Boolean] negate
        #   Inverts the bits of the IP address.
        #
        # @return [String]
        #   The packed IPv6 address in network byte-order.
        #
        def pack_ipv6(ip, negate: false)
          ipaddr = IPAddr.new(ip)

          unless ipaddr.ipv6?
            raise(ArgumentError,"IP must be an IPv6 address: #{ip.inspect}")
          end

          ipaddr = ~ipaddr if negate
          ipaddr.hton
        end

        #
        # Packs the port number in network byte-order.
        #
        # @param [Integer] port
        #   The port number to pack.
        #
        # @param [Boolean] negate
        #   Inverts the bits of the port number.
        #
        # @return [String]
        #   The packed port number in network byte-order.
        #
        def pack_port(port, negate: false)
          port = ~port if negate
          [port].pack('n')
        end
      end
    end
  end
end
