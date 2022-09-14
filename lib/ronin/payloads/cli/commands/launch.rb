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

module Ronin
  module Payloads
    class CLI
      module Commands
        class Launch < ScriptCommand

          summary 'Launches the specified Payload'

          script_class Ronin::Payloads::Payload

          query_option :targeting_arch, type:  String,
                                        flag:  '-a',
                                        usage: 'ARCH'

          query_option :targeting_os, type:  String,
                                      flag:  '-o',
                                      usage: 'OS'

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

            launch_payload
          end

          #
          # Launches the built payload.
          #
          def launch_payload
            begin
              @payload.deploy!
            rescue Behaviors::TestFailed, Payloads::Exception => e
              print_exception(e)
              exit -1
            end

            if shell?      then @payload.shell.console
            elsif fs?      then @payload.fs.console
            elsif console? then UI::Console.start(@payload)
            end

            @payload.evacuate!
          end

        end
      end
    end
  end
end
