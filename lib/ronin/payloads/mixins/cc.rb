# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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

module Ronin
  module Payloads
    module Mixins
      #
      # Mixin for using the C compiler.
      #
      # @since 0.2.0
      #
      module CC
        #
        # The default C compiler.
        #
        # @return [String]
        #
        def self.cc
          ENV['CC'] || 'cc'
        end

        def self.included(payload_class)
          payload_class.param :cc, required: true,
                                   default:  -> { cc },
                                   desc:     'The C compiler to use'
        end

        #
        # Compiles one or more source files using `cc`.
        #
        # @param [Array<String>] source_files
        #   The source file(s) to compile.
        #
        # @param [String] output
        #   The output file path.
        #
        # @param [Array<String>, Hash{Symbol,String => String}, nil] defs
        #   Additional macro definitions to pass to the compiler.
        #
        # @raise [ArgumentError]
        #   `defs` was not an Array or a Hash.
        #
        # @raise [BuildFailed]
        #   The `cc` command failed or is not installed.
        #
        def compile_c(*source_files, output: , defs: nil)
          args = [params[:cc], '-o', output]

          if defs
            case defs
            when Array
              defs.each do |value|
                args << "-D#{value}"
              end
            when Hash
              defs.each do |name,value|
                args << "-D#{name}=#{value}"
              end
            else
              raise(ArgumentError,"defs must be either an Array or a Hash: #{defs.inspect}")
            end
          end

          args.concat(source_files)

          case system(*args)
          when false
            raise(BuildFailed,"cc command failed: #{args.join(' ')}")
          when nil
            raise(BuildFailed,"cc command not installed")
          end
        end

        alias compile compile_c
      end
    end
  end
end
