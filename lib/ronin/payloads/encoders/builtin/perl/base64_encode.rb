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
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module Perl
        #
        # A Perl encoder that encodes the given Perl code as a Base64 string,
        # then decodes it using `Mime::Base64.code_base64()`, and then
        # evaluates the decoded Perl using `eval()`.
        #
        #    print("PWNED\\n") -> use MIME::Base64; eval(decode_base64("..."))
        #
        # @since 0.3.0
        #
        class Base64Encode < PerlEncoder

          register 'perl/base64_encode'

          summary 'Encodes Perl as Base64'

          description <<~DESC
            Encodes the given Perl code as a Base64 string, then decodes it
            using `Mime::Base64.code_base64()`, and then evaluates the decoded
            Perl using `eval()`.

              print("PWNED\\n") -> use MIME::Base64; eval(decode_base64("..."))

          DESC

          #
          # Encodes Perl code as Base64.
          #
          # @param [String] perl
          #   The Perl code to encode.
          #
          # @return [String]
          #
          def encode(perl)
            base64 = Support::Encoding::Base64.encode(perl, mode: :strict)

            %{use MIME::Base64; eval(decode_base64("#{base64}"))}
          end

        end
      end
    end
  end
end
