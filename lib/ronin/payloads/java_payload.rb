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
                    default:  ->{ javac },
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
      # @return [Boolean, nil]
      #   Indicates whether the `javac` command succeeded or failed.
      #
      def compile(*source_files, dest_dir: nil)
        args = []
        args << '-d' << dest_dir if dest_dir
        args.concat(source_files)

        system(params[:javac],*args)
      end

    end
  end
end
