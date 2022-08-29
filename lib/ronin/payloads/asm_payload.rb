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

require 'ronin/payloads/binary_payload'
require 'ronin/payloads/exceptions'
require 'ronin/asm/program'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents payloads written in Assembly (ASM).
    #
    class ASMPayload < BinaryPayload

      #
      # Creates an ASM Program.
      #
      # @yield []
      #   The given block represents the instructions of the ASM Program.
      #
      # @param [Symbol] arch
      #   The architecture for the ASM Program.
      #
      # @param [Symbol] os
      #   The Operating System for the ASM Program.
      #
      # @param [Hash{Symbol => Object}] define
      #   Constants to define in the program.
      #
      # @param [Hash{Symbol => Object}] kwargs
      #   Additional keyword arguments for `Ronin::ASM::Program#assemble`.
      #
      # @return [String]
      #   The assembled program.
      #
      # @raise [BuildFailed]
      #   The payload class did not set {arch Metadata::ClassMethods#arch}.
      #
      def assemble(arch: self.arch, os: self.os, define: {}, **kwargs, &block)
        unless arch
          raise(BuildFailed,"#{self.class}.arch not set")
        end

        program = ASM::Program.new(arch: arch, os: os, define: define, &block)
        program.assemble(**kwargs)
      end

    end
  end
end
