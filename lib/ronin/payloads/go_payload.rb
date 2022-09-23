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
      # @return [Boolean, nil]
      #   Indicates whether the Go compiler command succeeded or failed.
      #
      def compile(*source_files, output: nil)
        args = []

        if output
          args << '-o' <<  output
        end

        args.concat(source_files)

        system('go','build',*args)
      end

    end
  end
end
