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

require 'ronin/payloads/encoders/ruby_encoder'
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module Ruby
        #
        # A Ruby encoder that encodes the given Ruby code as a Base64 string,
        # then decodes it using `Base64.decode64()`, and then evaluates the
        # decoded Ruby code using `eval()`.
        #
        #    puts('PWNED') -> require 'base64'; eval(Base64.decode64("cHV0cygnUFdORUQnKQ=="))
        #
        # @since 0.3.0
        #
        class Base64Encode < RubyEncoder

          register 'ruby/base64_encode'

          summary 'Encodes Ruby as Base64'

          description <<~DESC
            Encodes the given Ruby code as a Base64 string, then decodes it
            using `"...".unpack1('m0')`, and then evaluates the decoded Ruby
            code using `eval()`.

              puts('PWNED') -> eval("cHV0cygnUFdORUQnKQ==".unpack1("m0"))

          DESC

          #
          # Encodes Ruby code as Base64.
          #
          # @param [String] ruby
          #   The Ruby code to encode.
          #
          # @return [String]
          #
          def encode(ruby)
            base64 = Support::Encoding::Base64.encode(ruby, mode: :strict)

            %{eval("#{base64}".unpack1("m0"))}
          end

        end
      end
    end
  end
end
