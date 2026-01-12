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

require 'ronin/payloads/windows_command_payload'

module Ronin
  module Payloads
    module Command
      module Windows
        #
        # A simple Windows touch command:
        #
        #     type nul >> C:\temp\pwned.txt
        #
        # @since 0.3.0
        #
        class Touch < WindowsCommandPayload

          register 'command/windows/touch'

          param :file, String, default: 'C:\temp\pwned.txt',
                               desc:    'The file to touch'

          #
          # Builds the Windows touch command.
          #
          def build
            @payload = "type nul >> #{params[:file]}"
          end

        end
      end
    end
  end
end
