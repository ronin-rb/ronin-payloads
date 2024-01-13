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
    # A {Payload} class that represents all Rust payloads.
    #
    class RustPayload < BinaryPayload

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
        :rust
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
      # @param [String, nil] target
      #   Target triple to compile for.
      #
      # @param [Hash, Array, nil] cfg
      #   Additional configuration flags to pass to `rustc`.
      #
      # @raise [ArgumentError]
      #   The `cfg` value was not a Hash or an Array.
      #
      # @raise [BuildFailed]
      #   The `rustc` command failed or is not installed.
      #
      # @since 0.2.0
      #
      def compile_rust(*source_files, output: nil, target: nil, cfg: nil)
        args = ['rustc']

        if output
          args << '-o' << output
        end

        if target
          args << '--target' << target
        end

        if cfg
          case cfg
          when Hash
            cfg.each do |key,value|
              args << '--cfg' << "#{key}=\"#{value}\""
            end
          when Array
            cfg.each do |value|
              args << '--cfg' << value.to_s
            end
          else
            raise(ArgumentError,"cfg value must be either a Hash or an Array: #{cfg.inspect}")
          end
        end

        args.concat(source_files)

        case system(*args)
        when false
          raise(BuildFailed,"rustc command failed: #{args.join(' ')}")
        when nil
          raise(BuildFailed,"rustc command not installed")
        end
      end

      alias compile compile_rust

    end
  end
end
