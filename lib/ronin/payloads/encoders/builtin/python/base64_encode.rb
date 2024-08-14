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
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module Python
        #
        # A Python encoder that encodes the given Python code as a Base64
        # string, then decodes it using `base64.b64decode()`, and then evaluates
        # the decoded Python code using `eval()`.
        #
        #    print('PWNED') -> import base64; eval(base64.b64decode("cHJpbnQoJ1BXTkVEJyk="))
        #
        # @since 0.3.0
        #
        class Base64Encode < PythonEncoder

          register 'python/base64_encode'

          summary 'Encodes Python as Base64'

          description <<~DESC
            Encodes the given Python code as a Base64 string, then decodes it
            using `base64.b64decode()`, and then evaluates the decoded Python
            code using `eval()`.

              print('PWNED') -> import base64; eval(base64.b64decode("cHJpbnQoJ1BXTkVEJyk="))

          DESC

          #
          # Encodes Python code as Base64.
          #
          # @param [String] python
          #   The Python code to encode.
          #
          # @return [String]
          #
          def encode(python)
            base64 = Support::Encoding::Base64.encode(python, mode: :strict)

            %{import base64; eval(base64.b64decode("#{base64}"))}
          end

        end
      end
    end
  end
end
