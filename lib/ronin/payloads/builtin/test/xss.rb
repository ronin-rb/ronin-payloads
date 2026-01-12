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

require 'ronin/payloads/javascript_payload'

module Ronin
  module Payloads
    module Test
      #
      # A test payload for Cross Site Scripting (XSS).
      #
      class XSS < JavaScriptPayload

        register 'test/xss'

        summary 'A XSS test payload'
        description <<~DESC
          A non-malicious test payload for testing Cross Site Scripting (XSS).
          Simply calls `alert(1)`.
        DESC

        param :javascript, default: 'alert(1)',
                           desc:    'The JavaScript to inject'

        #
        # Builds the XSS test payload.
        #
        def build
          @payload = params[:javascript]
        end

      end
    end
  end
end
