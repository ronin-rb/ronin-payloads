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

require 'ronin/payloads/encoders/shell_encoder'

module Ronin
  module Payloads
    module Encoders
      module Shell
        #
        # A shell encoder that replaces whitespace with the `${IFS}` shell
        # variable.
        #
        #     ls -la   -> ls${IFS}-la
        #     ls   -la -> ls${IFS}-la
        #     ls\\t-la  -> ls${IFS}-la
        #
        # @since 0.3.0
        #
        class IFS < ShellEncoder

          register 'shell/ifs'

          summary 'Replaces whitespace with ${IFS}'

          description <<~DESC
            Replaces whitespace with the `${IFS}` shell variable:

              ls -la   -> ls${IFS}-la
              ls   -la -> ls${IFS}-la
              ls\\t-la  -> ls${IFS}-la

          DESC

          #
          # Shell encodes the given data.
          #
          # @param [String] command
          #
          # @return [String]
          #
          def encode(command)
            command.gsub(/\s+/,'${IFS}')
          end

        end
      end
    end
  end
end
