# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/encoders/shell_encoder'
require 'ronin/support/encoding/shell'

module Ronin
  module Payloads
    module Encoders
      module Shell
        #
        # A shell encoder that encodes every character in the given String as
        # an Shell special character.
        #
        class Encode < ShellEncoder

          register 'shell/encode'

          summary 'Encodes every character as a Shell special character'

          description <<~DESC
            Encodes every character in the given String as an Shell special character:

              hello world -> \\x68\\x65\\x6c\\x6c\\x6f\\x20\\x77\\x6f\\x72\\x6c\\x64

          DESC

          #
          # Shell encodes the given data.
          #
          # @param [String] data
          #
          # @return [String]
          #
          def encode(data)
            Support::Encoding::Shell.encode(data)
          end

        end
      end
    end
  end
end
