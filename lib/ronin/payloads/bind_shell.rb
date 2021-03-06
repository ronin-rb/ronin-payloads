#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-payloads.
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

require 'ronin/payloads/payload'

module Ronin
  module Payloads
    #
    # A generic payload for interacting with Bind Shells.
    #
    #     require 'ronin/payloads/bind_shell'
    #
    #     payload = Ronin::Payloads::BindShell.new
    #     payload.protocol = :tcp
    #     payload.host = 'victim.com'
    #     payload.port = 1337
    #
    #     rpc.build!
    #     rpc.deploy!
    #
    #     rpc.shell.whoami
    #     # => "www"
    #
    class BindShell < Payload

      #
      # Creates a new bind shell payload.
      #
      # @param [Hash] attributes
      #   Attributes for the bind shell.
      #
      def initialize(attributes={})
        super(attributes)
      end

    end
  end
end
