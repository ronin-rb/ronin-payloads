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

require 'ronin/payloads/powershell_payload'

module Ronin
  module Payloads
    module Command
      module PowerShell
        #
        # A simple PowerShell command that touches a file.
        #
        #     New-Item -Path "%TEMP%/pwned.txt" -ItemType File
        #
        # @since 0.3.0
        #
        class Touch < PowerShellPayload

          register 'command/powershell/touch'

          param :file, String, default: 'C:\temp\pwned.txt',
                               desc:    'The file to touch'

          #
          # Builds the `Net-Item` command.
          #
          def build
            @payload = "New-Item -Path #{params[:file]} -ItemType File"
          end

        end
      end
    end
  end
end
