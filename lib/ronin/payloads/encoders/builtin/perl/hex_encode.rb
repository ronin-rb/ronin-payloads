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

require 'ronin/payloads/encoders/perl_encoder'
require 'ronin/support/encoding/hex'

module Ronin
  module Payloads
    module Encoders
      module Perl
        #
        # A Perl encoder that encodes the given Perl code as an hex string,
        # then decodes it using `pack("H*","...")`, and then evaluates the
        # decoded Perl code using `eval()`.
        #
        #     print "PWNED\n" -> eval(pack("H*","7072696e74202250574e45445c6e22"))
        #
        # @since 0.3.0
        #
        class HexEncode < PerlEncoder

          register 'perl/hex_encode'

          summary 'Encodes Perl as a hex string'

          description <<~DESC
            Encodes the given Perl code as an hex string, then decodes it
            using `binascii.unhexlify()`, and then evaluates the decoded Perl
            code using `eval()`.

              print "PWNED\\n" -> eval(pack("H*","7072696e74202250574e45445c6e22"))

          DESC

          #
          # Encodes the given Perl code.
          #
          # @param [String] perl
          #   The Perl code to encode.
          #
          # @return [String]
          #
          def encode(perl)
            hex = Support::Encoding::Hex.encode(perl)

            %{eval(pack("H*","#{hex}"))}
          end

        end
      end
    end
  end
end
