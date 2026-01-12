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

require 'ronin/payloads/encoders/shell_command_encoder'
require 'ronin/support/encoding/base64'

module Ronin
  module Payloads
    module Encoders
      module Shell
        #
        # A shell encoder that encodes a given command String as Base64 and
        # then decodes it using `base64 -d` and then executes the decoded
        # command String by piping it into a shell.
        #
        #     ls -la -> echo bHMgLWxh|base64 -d|bash
        #
        # @since 0.3.0
        #
        class Base64Encode < ShellCommandEncoder

          register 'shell/base64_encode'

          summary 'Encodes a command as Base64'

          description <<~DESC
            Encodes the given command String as Base64, then decodes it
            by piping it through `base64`, and then executes the command
            decoded command String by piping it into a shell.

              ls -la -> echo bHMgLWxh|base64 -d|bash

          DESC

          param :shell, required: true,
                        default:  'bash',
                        desc:     'The shell to use'

          #
          # Shell encodes the given data.
          #
          # @param [String] command
          #   The command to encode.
          #
          # @return [String]
          #
          def encode(command)
            base64 = Support::Encoding::Base64.encode(command, mode: :strict)
            shell  = params[:shell]

            "echo #{base64}|base64 -d|#{shell}"
          end

        end
      end
    end
  end
end
