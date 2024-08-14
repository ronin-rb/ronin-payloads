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

require 'ronin/payloads/encoders/node_js_encoder'
require 'ronin/support/encoding/hex'

module Ronin
  module Payloads
    module Encoders
      module JS
        module Node
          #
          # A Node.js encoder that encodes the given JavaScript code as an hex
          # string, then decodes it using
          # `Buffer.from("...","hex").toString("utf8")`, and then evaluates the
          # decoded JavaScript code using `eval()`.
          #
          #     print('PWNED') -> eval(Buffer.from("636f6e736f6c652e6c6f67282750574e45442729","hex").toString("utf8"))
          #
          # @since 0.3.0
          #
          class HexEncode < NodeJSEncoder

            register 'js/node/hex_encode'

            summary 'Encodes Node.js as a hex string'

            description <<~DESC
              Encodes the given JavaScript code as an hex string, then decodes
              it using `Buffer.from("...","hex").toString("utf8")`, and then
              evaluates the decoded JavaScript code using `eval()`.

                  console.log('PWNED') -> eval(Buffer.from("636f6e736f6c652e6c6f67282750574e45442729","hex").toString("utf8"))

            DESC

            #
            # Encodes the given JavaScript code.
            #
            # @param [String] javascript
            #   The JavaScript code to encode.
            #
            # @return [String]
            #
            def encode(javascript)
              hex = Support::Encoding::Hex.encode(javascript)

              %{eval(Buffer.from("#{hex}","hex").toString("utf8"))}
            end

          end
        end
      end
    end
  end
end
