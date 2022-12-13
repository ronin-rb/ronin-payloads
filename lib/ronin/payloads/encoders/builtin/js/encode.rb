#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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
        # as an JavaScript special character.
        #
        class Encode < JavaScriptEncoder

          register 'js/encode'

          summary 'Encodes every character as a JavaScript special character'

          description <<~DESC
            Encodes every character in the given String as an JavaScript special character:

              hello world -> \\x68\\x65\\x6C\\x6C\\x6F\\x20\\x77\\x6F\\x72\\x6C\\x64

          DESC

          #
          # JS encodes the given data.
          #
          # @param [String] data
          #
          # @return [String]
          #
          def encode(data)
            Support::Encoding::JS.encode(data)
          end

        end
      end
    end
  end
end
