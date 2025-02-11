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

require 'ronin/payloads/sql_payload'

module Ronin
  module Payloads
    module Test
      #
      # A test SQL payload. Allows using a custom SQL expression with exploits
      # that require a SQL payload.
      #
      # @since 0.3.0
      #
      class SQL < SQLPayload

        register 'test/sql'

        summary "A test SQL payload"
        description <<~DESC
          Allows specifying a custom SQL expression for exploits that require a
          SQL payload.
        DESC

        param :sql, String, default: %{SELECT(1)},
                            desc:    'The SQL expression to execute'

        def build
          @payload = params[:sql]
        end

      end
    end
  end
end
