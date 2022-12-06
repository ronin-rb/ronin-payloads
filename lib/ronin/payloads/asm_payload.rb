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
require 'ronin/payloads/metadata/arch'
require 'ronin/payloads/metadata/os'
require 'ronin/payloads/exceptions'
require 'ronin/code/asm/program'

require 'tempfile'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents payloads written in Assembly (ASM).
    #
    class ASMPayload < BinaryPayload

      include Metadata::Arch
      include Metadata::OS

      #
      # Returns the type or kind of payload.
      #
      # @return [Symbol]
      #
      # @note
      #   This is used internally to map an payload class to a printable type.
      #
      # @api private
      #
      def self.payload_type
        :asm
      end

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

        program = Code::ASM::Program.new(arch:   arch,
                                         os:     os,
                                         define: define,
                                         &block)

        tempfile = Tempfile.new('ronin-payloads', encoding: Encoding::ASCII_8BIT)
        program.assemble(tempfile.path,**kwargs)
        return tempfile.read
      end

    end
  end
end
