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
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module JS
        #
        # A JavaScript encoder that encodes the given String as Base64, decodes
        # it using `window.btoa()`, and then evaluates it using `eval()`.
        #
        #     alert(1) -> eval(window.btoa("YWxlcnQoMSk="))
        #
        class Base64Encode < JavaScriptEncoder

          register 'js/base64_encode'

          summary 'Encodes JavaScript as Base64'

          description <<~DESC
            Encodes the given JavaScript as Base64, then decodes it using
            `window.btoa()`, and then evaluates it using `eval()`:

              alert(1) -> eval(window.btoa("YWxlcnQoMSk="))

          DESC

          #
          # Encodes the given JavaScript code.
          #
          # @param [String] javascript
          #
          # @return [String]
          #
          def encode(javascript)
            base64 = Support::Encoding::Base64.encode(javascript, mode: :strict)

            %{eval(window.btoa("#{base64}"))}
          end

        end
      end
    end
  end
end
