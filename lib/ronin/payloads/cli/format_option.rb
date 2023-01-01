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
    class CLI
      #
      # Adds a `-F,--format hex|c|shell|powershell|xml|html|js|ruby` option.
      #
      module FormatOption
        # Available formats.
        FORMATS = {
          hex: -> {
            require 'ronin/support/encoding/hex'
            Support::Encoding::Hex.method(:escape)
          },

          c: -> {
            require 'ronin/support/encoding/c'
            Support::Encoding::C.method(:quote)
          },

          shell: -> {
            require 'ronin/support/encoding/shell'
            Support::Encoding::Shell.method(:quote)
          },

          powershell: -> {
            require 'ronin/support/encoding/powershell'
            Support::Encoding::PowerShell.method(:quote)
          },

          xml: -> {
            require 'ronin/support/encoding/xml'
            Support::Encoding::XML.method(:escape)
          },

          html: -> {
            require 'ronin/support/encoding/html'
            Support::Encoding::HTML.method(:escape)
          },

          js: -> {
            require 'ronin/support/encoding/js'
            Support::Encoding::JS.method(:quote)
          },

          ruby: -> {
            require 'ronin/support/encoding/ruby'
            Support::Encoding::Ruby.method(:quote)
          }
        }

        #
        # Adds the `-F,--format hex|c|shell|powershell|xml|html|js|ruby` option.
        #
        # @param [Class<Command>] command
        #   The command class including {FormatOption}.
        #
        def self.included(command)
          command.option :format, short: '-F',
                                  value: {type: FORMATS.keys},
                                  desc: 'Formats the outputed data' do |format|
                                    @format = FORMATS.fetch(format).call
                                  end
        end

        # The format to encode data with.
        #
        # @return [Method, nil]
        attr_reader :format

        #
        # Formats the given data based on the `-F,--format` option.
        #
        # @param [String] data
        #   The data to format.
        #
        # @return [String]
        #   The formatted data.
        #
        def format_data(data)
          if @format then @format.call(data)
          else            data
          end
        end

        #
        # Formats and prints the given data.
        #
        # @param [String] data
        #   The raw data to format and print.
        #
        def print_data(data)
          formatted_data = format_data(data)

          if stdout.tty? then puts formatted_data
          else                stdout.write(formatted_data)
          end
        end
      end
    end
  end
end
