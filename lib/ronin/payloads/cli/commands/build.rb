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

require 'ronin/ui/cli/script_command'
require 'ronin/payloads/payload'
require 'ronin/formatting/binary'

module Ronin
  module Payloads
    class CLI
      module Commands
        class Build < ScriptCommand

          summary 'Builds the specified Payload'

          script_class Ronin::Payloads::Payload

          query_option :targeting_arch, type:  String,
                                        flag:  '-a',
                                        usage: 'ARCH'

          query_option :targeting_os, type:  String,
                                      flag:  '-o',
                                      usage: 'OS'

          option :print, type:        true,
                         default:     true,
                         description: 'Prints the raw payload'

          option :string, type:        true,
                          default:     true,
                          flag:        '-s',
                          description: 'Prints the raw payload as a String'

          option :raw, type:        true,
                       flag:        '-r',
                       description: 'Prints the raw payload'

          option :hex, type:        true,
                       flag:        '-x',
                       description: 'Prints the raw payload in hex'

          #
          # Sets up the Payload command.
          #
          def setup
            super

            # silence all output, if we are to print the built payload
            UI::Output.silent! if raw?
          end

          #
          # Builds and optionally deploys the loaded payload.
          #
          def execute
            begin
              # Build the payload
              @payload.build!
            rescue Behaviors::Exception,
                   Payloads::Exception => error
              print_error error.message
              exit -1
            end

            print_payload!
          end

          protected

          #
          # Prints the built payload.
          #
          def print_payload
            raw_payload = @payload.raw_payload

            if raw?
              # Write the raw payload
              write raw_payload
            elsif hex?
              # Prints the raw payload as a hex String
              puts raw_payload.hex_escape
            else
              # Prints the raw payload as a String
              puts raw_payload.dump
            end
          end

        end
      end
    end
  end
end
