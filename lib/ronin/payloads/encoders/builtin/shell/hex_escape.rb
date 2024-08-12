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
require 'ronin/support/encoding/shell'

require 'shellwords'

module Ronin
  module Payloads
    module Encoders
      module Shell
        #
        # A shell encoder that encodes the arguments of a given command String
        # as hex escaped shell strings then executes it as a command in a
        # sub-shell.
        #
        #     ls -la -> $'\x6c\x73' $'\x2d\x6c\x61'
        #
        # @since 0.3.0
        #
        class HexEscape < ShellEncoder

          register 'shell/hex_escape'

          summary 'Hex escapes a command string'

          description <<~DESC
            Encodes the arguments of a given command String as hex escaped shell
            strings then executes it as a command in a sub-shell.

              ls -la -> $'\\x6c\\x73' $'\\x2d\\x6c\\x61'

          DESC

          #
          # Hex escapes the given command.
          #
          # @param [String] command
          #
          # @return [String]
          #
          def encode(command)
            Shellwords.shellsplit(command).map { |arg|
              "$'#{Support::Encoding::Shell.encode(arg)}'"
            }.join(' ')
          end

        end
      end
    end
  end
end
