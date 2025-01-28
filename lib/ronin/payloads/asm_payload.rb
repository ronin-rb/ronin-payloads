# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative 'binary_payload'
require_relative 'metadata/arch'
require_relative 'metadata/os'
require_relative 'exceptions'
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
      # The default assembler.
      #
      # @return [String]
      #
      def self.assembler
        ENV['AS'] || 'as'
      end

      param :assembler, required: true,
                        default:  -> { assembler },
                        desc:     'The assmebler command to use'

      #
      # Assembles one or more source files using `as`.
      #
      # @param [Array<String>] source_files
      #   The source file(s) to assemble.
      #
      # @param [String] output
      #   The output file path.
      #
      # @param [Hash{Symbol => Object}] defs
      #   Additional symbols to define in the program.
      #
      # @return [Boolean, nil]
      #   Indicates whether the assembler command succeeded or failed.
      #
      def assemble(*source_files, output: , defs: {})
        args = [params[:assembler], '-o', output]

        defs.each do |name,value|
          args << "--defsym" << "#{name}=#{value}"
        end

        args.concat(source_files)

        case system(*args)
        when false
          raise(BuildFailed,"assembler command failed: #{args.join(' ')}")
        when nil
          raise(BuildFailed,"assembler command not installed")
        end
      end

    end
  end
end
