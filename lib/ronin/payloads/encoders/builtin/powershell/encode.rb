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

require_relative '../../powershell_encoder'

require 'ronin/support/encoding/powershell'

module Ronin
  module Payloads
    module Encoders
      module PowerShell
        #
        # A PowerShell encoder that encodes every character in the given String
        # as an PowerShell special character.
        #
        class Encode < PowerShellEncoder

          register 'powershell/encode'

          summary 'Encodes every character as a PowerShell special character'

          description <<~DESC
            Encodes every character in the given String as an PowerShell special character:

              hello world -> $([char]0x68)$([char]0x65)$([char]0x6c)$([char]0x6c)$([char]0x6f)$([char]0x20)$([char]0x77)$([char]0x6f)$([char]0x72)$([char]0x6c)$([char]0x64)

          DESC

          #
          # HTML encodes the given data.
          #
          # @param [String] data
          #
          # @return [String]
          #
          def encode(data)
            Support::Encoding::PowerShell.encode(data)
          end

        end
      end
    end
  end
end
