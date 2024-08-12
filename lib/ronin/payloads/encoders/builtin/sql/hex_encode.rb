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

require 'ronin/payloads/encoders/sql_encoder'
require 'ronin/support/encoding/sql'

module Ronin
  module Payloads
    module Encoders
      module SQL
        #
        # A SQL encoder that encodes the given String as a SQL hex string.
        #
        class HexEncode < SQLEncoder

          register 'sql/hex_encode'

          summary 'Encodes the data as a SQL hex string'

          description <<~DESC
            Encodes the given String as a SQL hex string:

              hello world -> 0x68656c6c6f20776f726c64

          DESC

          #
          # SQL encodes the given data.
          #
          # @param [String] data
          #
          # @return [String]
          #
          def encode(data)
            Support::Encoding::SQL.encode(data)
          end

        end
      end
    end
  end
end
