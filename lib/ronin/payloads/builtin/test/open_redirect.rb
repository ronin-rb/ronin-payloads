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

require 'ronin/payloads/url_payload'

module Ronin
  module Payloads
    module Test
      #
      # A test payload for Open Redirects.
      #
      class OpenRedirect < URLPayload

        register 'test/open_redirect'

        summary 'An Open Redirect test payload'
        description <<~DESC
        A non-malicious test payload for testing Open Redirect vulnerabilities.
        Simply redirects to https://google.com/.
        DESC
        
        #
        # Builds the Open Redirect test payload.
        #
        def build
          @payload = 'https://google.com/'
        end

      end
    end
  end
end
