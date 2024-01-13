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

require 'ronin/payloads/binary_payload'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents all Go payloads.
    #
    class GoPayload < BinaryPayload

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
        :go
      end

      #
      # Compiles one or more source files using the `go build` command.
      #
      # @param [Array<String>] source_files
      #   The source file(s) to compile.
      #
      # @param [String, nil] output
      #   The output file path.
      #
      # @raise [BuildFailed]
      #   The `go build` command failed or is not installed.
      #
      # @since 0.2.0
      #
      def compile_go(*source_files, output: nil)
        args = ['go', 'build']

        if output
          args << '-o' << output
        end

        args.concat(source_files)

        case system(*args)
        when false
          raise(BuildFailed,"go command failed: #{args.join(' ')}")
        when nil
          raise(BuildFailed,"go command not installed")
        end
      end

      alias compile compile_go

    end
  end
end
