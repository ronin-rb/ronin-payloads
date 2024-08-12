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

require 'ronin/payloads/encoders/javascript_encoder'
require 'ronin/support/encoding/js'

module Ronin
  module Payloads
    module Encoders
      module JS
        #
        # A JavaScript encoder that encodes every character in the given String
        # as an JavaScript special character and evaluates it using `eval()`.
        #
        #     alert(1) -> eval("\\x61\\x6C\\x65\\x72\\x74\\x28\\x31\\x29")
        #
        class HexEncode < JavaScriptEncoder

          register 'js/hex_encode'

          summary 'Encodes every character as a JavaScript special character'

          description <<~DESC
            Encodes every character in the given String as an JavaScript
            special character and evaluates it using `eval()`:

              alert(1) -> eval("\\x61\\x6C\\x65\\x72\\x74\\x28\\x31\\x29")

          DESC

          #
          # Encodes the given JavaScript code.
          #
          # @param [String] javascript
          #
          # @return [String]
          #
          def encode(javascript)
            "eval(\"#{Support::Encoding::JS.encode(javascript)}\")"
          end

        end
      end
    end
  end
end
