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

require 'ronin/payloads/encoders/python_encoder'
require 'ronin/support/encoding/hex'

module Ronin
  module Payloads
    module Encoders
      module Python
        #
        # A Python encoder that encodes the given Python code as an hex string,
        # then decodes it using `binascii.unhexlify()`, and then execuates the
        # decoded Python code using `exec()`.
        #
        #     print('PWNED') -> import binascii; exec(binascii.unhexlify("7072696e74282750574e45442729"))
        #
        # @since 0.3.0
        #
        class HexEncode < PythonEncoder

          register 'python/hex_encode'

          summary 'Encodes Python as a hex string'

          description <<~DESC
            Encodes the given Python code as an hex string, then decodes it
            using `binascii.unhexlify()`, and then execuates the decoded Python
            code using `exec()`.

              print('PWNED') -> import binascii; exec(binascii.unhexlify("7072696e74282750574e45442729"))

            Note: supports Python 2 and 3.
          DESC

          #
          # Encodes the given Python code.
          #
          # @param [String] python
          #   The Python code to encode.
          #
          # @return [String]
          #
          def encode(python)
            hex = Support::Encoding::Hex.encode(python)

            %{import binascii; exec(binascii.unhexlify("#{hex}"))}
          end

        end
      end
    end
  end
end
