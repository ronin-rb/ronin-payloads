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

require 'ronin/payloads/powershell_payload'

module Ronin
  module Payloads
    module Test
      #
      # A test PowerShell payload. Allows using custom PowerShell code with
      # exploits that require a PowerShell payload. Defaults to printing `PWNED`
      # using `Write-Output`.
      #
      # @since 0.3.0
      #
      class PowerShell < PowerShellPayload

        register 'test/powershell'

        summary "A test PowerShell payload"
        description <<~DESC
          Allows specifying custom PowerShell code for exploits that require a
          PowerShell payload. By default it prints `PWNED` using `Write-Output`.
        DESC

        param :powershell, String, default: %{Write-Output "PWNED";},
                                   desc:    'The PowerShell code to execute'

        def build
          @payload = params[:powershell]
        end

      end
    end
  end
end
