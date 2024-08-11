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
require 'ronin/support/encoding/hex'

module Ronin
  module Payloads
    module Encoders
      module Shell
        #
        # A shell encoder that encodes a given command String as a hex string
        # then decodes it using `xxd -r -p` and then executes the decoded
        # command String by piping it into a shell.
        #
        #     ls -la -> echo 6c73202d6c61|xxd -r -p|bash
        #
        # @since 0.3.0
        #
        class HexEncode < ShellEncoder

          register 'shell/hex_encode'

          summary 'Encodes a command as a hex string'

          description <<~DESC
            Encodes the given command String as an hex string, then decodes it
            by piping it through `xxd -r -p`, and then executes the command
            decoded command String by piping it into a shell.

              ls -la -> echo 6c73202d6c61|xxd -r -p|bash

          DESC

          param :shell, required: true,
                        default:  'bash',
                        desc:     'The shell to use'

          #
          # Encodes the given command.
          #
          # @param [String] command
          #   The command to encode.
          #
          # @return [String]
          #
          def encode(command)
            hex   = Support::Encoding::Hex.encode(command)
            shell = params[:shell]

            "echo #{hex}|xxd -r -p|#{shell}"
          end

        end
      end
    end
  end
end
