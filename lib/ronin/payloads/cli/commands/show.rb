# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../payload_command'
require_relative '../text'
require_relative '../../metadata/arch'
require_relative '../../metadata/os'

require 'ronin/core/cli/text/arch'
require 'ronin/core/cli/text/os'
require 'ronin/core/cli/printing/metadata'
require 'ronin/core/cli/printing/params'

require 'command_kit/printing/fields'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Prints information about a payload.
        #
        # ## Usage
        #
        #     ronin-payloads show [options] {--file FILE | NAME}
        #
        # ## Options
        #
        #     -f, --file FILE                  The optional file to load the payload from
        #     -v, --verbose                    Enables verbose output
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     NAME                             The name of the payload to load
        #
        class Show < PayloadCommand

          include Core::CLI::Text::Arch
          include Core::CLI::Text::OS
          include Core::CLI::Printing::Metadata
          include Core::CLI::Printing::Params
          include CommandKit::Printing::Fields
          include Text

          description 'Prints information about a payload'

          man_page 'ronin-payloads-show.1'

          #
          # Runs the `ronin-payloads show` command.
          #
          # @param [String] name
          #   The optional name of the payload to load and print metadata about.
          #
          def run(name=nil)
            super(name)

            print_payload(payload_class)
          end

          #
          # Prints the metadata for a payload class.
          #
          # @param [Class<Payload>] payload
          #
          def print_payload(payload)
            puts "[ #{payload.id} ]"
            puts

            indent do
              fields = {}

              fields['Type']    = payload_type_name(payload)
              fields['Summary'] = payload.summary if payload.summary

              if payload.include?(Metadata::Arch)
                if (arch = payload.arch)
                  fields['Arch'] = arch_name(arch)
                end
              end

              if payload.include?(Metadata::OS)
                if (os = payload.os)
                  fields['OS'] = os_name(os)
                end
              end

              print_fields(fields)
              puts

              print_authors(payload)
              print_description(payload)
              print_references(payload)
              print_params(payload)
              print_payload_usage(payload)
            end
          end

          #
          # Prints an example `ronin-payloads build` command for the payload.
          #
          # @param [Class<Payload>] payload
          #
          # @since 0.2.0
          #
          def print_payload_usage(payload)
            puts "Usage:"
            puts
            puts "  $ #{example_payload_command(payload)}"
            puts
          end

          #
          # Builds an example `ronin-payloads build` command for the payload.
          #
          # @param [Class<Payload>] payload_class
          #   The payload class.
          #
          # @return [String]
          #   The example `ronin-payloads build` command.
          #
          def example_payload_command(payload_class)
            super(payload_class, file: options[:file])
          end

        end
      end
    end
  end
end
