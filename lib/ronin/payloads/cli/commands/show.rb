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

require 'ronin/payloads/cli/payload_command'
require 'ronin/payloads/metadata/arch'
require 'ronin/payloads/metadata/os'
require 'ronin/core/cli/printing/metadata'
require 'ronin/core/cli/printing/arch'
require 'ronin/core/cli/printing/os'

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

          include Core::CLI::Printing::Metadata
          include Core::CLI::Printing::Arch
          include Core::CLI::Printing::OS
          include CommandKit::Printing::Fields

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
          # Prints the mdatadata for a payload class.
          #
          # @param [Class<Payload>] payload
          #
          def print_payload(payload)
            puts "[ #{payload.id} ]"
            puts

            indent do
              fields = {}
              fields['Type']    = payload_type(payload)
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

          #
          # Returns the printable payload type for the payload class.
          #
          # @param [Class<Payload>] payload_class
          #   The payload class.
          #
          # @return [String]
          #   The printable payload type (ex: 'ASM' or 'shellcode').
          #
          def payload_type(payload_class)
            if    defined?(HTMLPayload) && payload_class < HTMLPayload
              'HTML'
            elsif defined?(XMLPayload) && payload_class < XMLPayload
              'XML'
            elsif defined?(SQLPayload) && payload_class < SQLPayload
              'SQL'
            elsif defined?(ShellPayload) && payload_class < ShellPayload
              'shell'
            elsif defined?(PowerShellPayload) &&
                  payload_class < PowerShellPayload
              'PowerShell'
            elsif defined?(CPayload) && payload_class < CPayload
              'C'
            elsif defined?(JavaPayload) && payload_class < JavaPayload
              'Java'
            elsif defined?(ColdFusionPayload) &&
                  payload_class < ColdFusionPayload
              'ColdFusion'
            elsif defined?(PHPPayload) && payload_class < PHPPayload
              'PHP'
            elsif defined?(NodeJSPayload) && payload_class < NodeJSPayload
              if defined?(Mixins::TypeScript) &&
                  payload_class.include?(Mixins::TypeScript)
                'Node.js (TypeScript)'
              else
                'Node.js'
              end
            elsif defined?(JavaScriptPayload) &&
                  payload_class < JavaScriptPayload
              if defined?(Mixins::TypeScript) &&
                  payload_class.include?(Mixins::TypeScript)
                'JavaScript (TypeScript)'
              else
                'JavaScript'
              end
            elsif defined?(BinaryPayload) &&
                  payload_class < BinaryPayload
              if defined?(ShellcodePayload) && payload_class < ShellcodePayload
                'shellcode'
              elsif defined?(ASMPayload) && payload_class < ASMPayload
                'ASM'
              else
                'binary'
              end
            else
              'custom'
            end
          end

        end
      end
    end
  end
end
