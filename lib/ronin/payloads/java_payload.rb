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

require 'ronin/payloads/payload'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents Java payloads.
    #
    class JavaPayload < Payload

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
        :java
      end

      #
      # The default Java compiler.
      #
      # @return [String]
      #
      def self.javac
        ENV['JAVAC'] || 'javac'
      end

      param :javac, required: true,
                    default:  -> { javac },
                    desc:     'The Java compiler to use'

      #
      # Compiles one or more source files using `javac`.
      #
      # @param [Array<String>] source_files
      #   The source files for the `javac` command.
      #
      # @param [String, nil] dest_dir
      #   The destination directory that class files will be written to.
      #
      # @raise [BuildFailed]
      #   The `javac` command failed or is not installed.
      #
      # @since 0.2.0
      #
      def compile_java(*source_files, dest_dir: nil)
        args = [params[:javac]]
        args << '-d' << dest_dir if dest_dir
        args.concat(source_files)

        case system(*args)
        when false
          raise(BuildFailed,"javac command failed: #{args.join(' ')}")
        when nil
          raise(BuildFailed,"javac command not installed")
        end
      end

      alias compile compile_java

    end
  end
end
