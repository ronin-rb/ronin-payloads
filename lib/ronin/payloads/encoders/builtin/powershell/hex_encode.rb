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

require 'ronin/payloads/encoders/powershell_encoder'
require 'ronin/support/encoding/powershell'

module Ronin
  module Payloads
    module Encoders
      module PowerShell
        #
        # A PowerShell encoder that encodes every character in the given
        # PowerShell command as PowerShell `$([char]0xXX)` characters and
        # evaluates the resulting String using `Invoke-Expression`.
        #
        #     dir -> Invoke-Expression "$([char]0x64)$([char]0x69)$([char]0x72)"
        #
        class HexEncode < PowerShellEncoder

          register 'powershell/hex_encode'

          summary 'Encodes every character as a PowerShell special character'

          description <<~DESC
            Encodes every character in the given PowerShell command as
            PowerShell `$([char]0xXX)` characters and evaluates the resulting
            PowerShell String using `Invoke-Expression`:

                dir -> Invoke-Expression \\"$([char]0x64)$([char]0x69)$([char]0x72)\\"

          DESC

          #
          # Encodes the given PowerShell command.
          #
          # @param [String] command
          #
          # @return [String]
          #
          def encode(command)
            hex_chars = Support::Encoding::PowerShell.encode(command)

            %{Invoke-Expression "#{hex_chars}"}
          end

        end
      end
    end
  end
end
