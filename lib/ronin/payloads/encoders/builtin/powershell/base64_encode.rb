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

require 'ronin/payloads/encoders/powershell_encoder'
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module PowerShell
        #
        # A PowerShell encoder that encodes the given PowerShell code as a
        # Base64 string, then decodes it using
        # `[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("..."))`,
        # and then evaluates the decoded PowerShell code using
        # `Invoke-Expression()`.
        #
        #    Write-Output 'PWNED' -> Invoke-Expression([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("V3JpdGUtT3V0cHV0ICdQV05FRCc=")))
        #
        # @since 0.3.0
        #
        class Base64Encode < PowerShellEncoder

          register 'powershell/base64_encode'

          summary 'Encodes PowerShell as Base64'

          description <<~DESC
            encodes the given PowerShell code as a Base64 string, then decodes
            it using `[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("..."))`,
            and then evaluates the decoded PowerShell code using
            `Invoke-Expression()`.

              Write-Output 'PWNED' -> Invoke-Expression([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("V3JpdGUtT3V0cHV0ICdQV05FRCc=")))

          DESC

          #
          # Encodes PowerShell code as Base64.
          #
          # @param [String] powershell
          #   The PowerShell code to encode.
          #
          # @return [String]
          #
          def encode(powershell)
            base64 = Support::Encoding::Base64.encode(powershell, mode: :strict)

            %{Invoke-Expression([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("#{base64}")))}
          end

        end
      end
    end
  end
end
