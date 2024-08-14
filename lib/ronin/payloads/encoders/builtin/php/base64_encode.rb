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

require 'ronin/payloads/encoders/php_encoder'
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module PHP
        #
        # A PHP encoder that encodes the given PHP code as a Base64 string, then
        # decodes it using `base64_decode()`, and then evaluates the decoded PHP
        # code using `eval()`.
        #
        #    echo 'PWNED'; -> eval(base64_decode("ZWNobyAnUFdORUQnOw=="));
        #
        # @since 0.3.0
        #
        class Base64Encode < PHPEncoder

          register 'php/base64_encode'

          summary 'Encodes PHP as Base64'

          description <<~DESC
            Encodes the given PHP code as a Base64 string, then decodes it using
            `base64_decode()`, and then evaluates the decoded PHP code using
            `eval()`.

              echo 'PWNED'; -> eval(base64_decode("ZWNobyAnUFdORUQnOw=="));

          DESC

          #
          # Encodes PHP code as Base64.
          #
          # @param [String] php
          #   The PHP code to encode.
          #
          # @return [String]
          #
          def encode(php)
            base64 = Support::Encoding::Base64.encode(php, mode: :strict)

            %{eval(base64_decode("#{base64}"));}
          end

        end
      end
    end
  end
end
