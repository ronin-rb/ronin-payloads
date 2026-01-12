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

require 'ronin/payloads/encoders/ruby_encoder'
require 'ronin/support/encoding/hex'

module Ronin
  module Payloads
    module Encoders
      module Ruby
        #
        # A Ruby encoder that encodes the given Ruby code as an hex string,
        # then decodes it using `.scan(/../).map(&:hex).map(&:chr).join`, and
        # then evaluates the decoded Ruby code using `eval()`.
        #
        #     puts('PWNED') -> eval("70757473282750574e45442729".scan(/../).map(&:hex).map(&:chr).join)
        #
        # @since 0.3.0
        #
        class HexEncode < RubyEncoder

          register 'ruby/hex_encode'

          summary 'Encodes Ruby as a hex string'

          description <<~DESC
            Encodes the given Ruby code as an hex string, then decodes it
            using `.scan(/../).map(&:hex).map(&:chr).join`, and then evaluates
            the decoded Ruby code using `eval()`.

              puts('PWNED') -> eval("70757473282750574e45442729".scan(/../).map(&:hex).map(&:chr).join)

          DESC

          #
          # Encodes the given Ruby code.
          #
          # @param [String] ruby
          #   The Ruby code to encode.
          #
          # @return [String]
          #
          def encode(ruby)
            hex = Support::Encoding::Hex.encode(ruby)

            %{eval("#{hex}".scan(/../).map(&:hex).map(&:chr).join)}
          end

        end
      end
    end
  end
end
