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

require 'ronin/payloads/cli/command'
require 'ronin/payloads/cli/printing/metadata'
require 'ronin/payloads/cli/payload_methods'
require 'ronin/payloads/metadata/arch'
require 'ronin/payloads/metadata/os'
require 'ronin/core/cli/printing/metadata'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Prints information about a payload.
        #
        # ## Usage
        #
        #     ronin-payloads show [options] NAME
        #
        # ## Options
        #
        #     -v, --verbose                    Enables verbose output
        #     -f, --file FILE                  The optional file to load the payload from
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     NAME                             The name of the payload to load
        #
        class Show < Command

          include PayloadMethods
          include Core::CLI::Printing::Metadata
          include Printing::Metadata

          usage '[options] NAME'

          option :file, short: '-f',
                        value: {
                          type:  String,
                          usage: 'FILE'
                        },
                        desc: 'The optional file to load the payload from'

          argument :name, required: true,
                          desc:     'The name of the payload to load'

          description 'Prints information about a payload'

          man_page 'ronin-payloads-show.1'

          #
          # Runs the `ronin-payloads show` command.
          #
          # @param [String] name
          #   The optional name of the payload to load and print metadata about.
          #
          def run(name)
            print_payload(load_payload(name))
          end

          #
          # Loads a payload class.
          #
          # @param [String] name
          #   The payload ID to load.
          #
          # @return [Class<Payload>]
          #   The loaded payload class.
          #
          def load_payload(name)
            super(name,options[:file])
          end

          #
          # Prints the mdatadata for a payload class.
          #
          # @param [Class<Payload>] payload
          #
          def print_payload(payload)
            puts "[ #{payload.id} ]"
            puts

            indent do
              fields = {}
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

              print_fields fields
              puts

              print_authors(payload)
              print_description(payload)
              print_references(payload)
            end
          end

        end
      end
    end
  end
end
