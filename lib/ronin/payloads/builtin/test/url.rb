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

require_relative '../../url_payload'

module Ronin
  module Payloads
    module Test
      #
      # A test URL payload. Allows using a custom URL with exploits that
      # require a URL payload.
      #
      # @since 0.2.0
      #
      class URL < URLPayload

        register 'test/url'

        summary "A test command payload"
        description <<~DESC
          Allows specifying a custom URL for exploits that require a
          URL payload.
        DESC

        param :url, String, default: 'http://example.com',
                            desc:    'The custom URL'

        def build
          @payload = params[:url]
        end

      end
    end
  end
end
