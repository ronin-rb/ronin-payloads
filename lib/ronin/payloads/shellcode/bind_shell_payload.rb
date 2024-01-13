# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/shellcode_payload'
require 'ronin/payloads/mixins/bind_shell'
require 'ronin/payloads/mixins/resolve_host'
require 'ronin/payloads/mixins/network'

module Ronin
  module Payloads
    module Shellcode
      #
      # Base class for all bind shell shellcode payloads.
      #
      # @api public
      #
      class BindShellPayload < ShellcodePayload

        include Mixins::BindShell
        include Mixins::ResolveHost
        include Mixins::Network

        #
        # The bind shell's packed port number in network byte-order.
        #
        # @param [Hash{Symbol => Object}] kwargs
        #   Additional keyword arguments for {#pack_port}.
        #
        # @option kwargs [Boolean] :negate
        #   Inverts the bits of the port number.
        #
        # @return [String]
        #   The packed port number in network byte-order.
        #
        def packed_port(**kwargs)
          pack_port(port,**kwargs)
        end

      end
    end
  end
end
