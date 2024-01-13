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

require 'ronin/payloads/cli/payload_command'
require 'ronin/payloads/cli/ruby_shell'
require 'ronin/core/cli/options/param'
require 'ronin/core/cli/logging'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Launches a payload.
        #
        # ## Usage
        #
        #     ronin-payloads launch [options] {-f FILE | NAME}
        #
        # ## Options
        #
        #     -f, --file FILE                  The payload file to load
        #     -p, --param NAME=VALUE           Sets a param
        #     -D, --debug                      Enables debugging messages
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [NAME]                           The payload name to load
        #
        class Launch < PayloadCommand

          include Core::CLI::Options::Param
          include Core::CLI::Logging

          option :debug, short: '-D',
                         desc: 'Enables debugging messages' do
                           Support::CLI::Printing.debug = true
                         end

          description 'Launches a payload'

          man_page 'ronin-payloads-launch.1'

          #
          # Performs the prelaunch or postlaunch steps of a payload.
          #
          # @param [String, nil] name
          #   The name of the payload to load.
          #
          def run(name=nil)
            super(name)

            initialize_payload
            launch_payload
            start_shell
          end

          #
          # Initializes the payload with the `--param` options.
          #
          def initialize_payload
            super(params: @params)
          end

          #
          # Launches the loaded payload.
          #
          def launch_payload
            log_info "Launching payload #{@payload.class_id} ..."

            begin
              @payload.perform_prelaunch
              @payload.perform_postlaunch
            rescue PayloadError => error
              print_error("failed to launch payload #{@payload.class_id}: #{error.message}")
              exit(1)
            rescue => error
              print_exception(error)
              print_error "an unhandled exception occurred while launching payload #{@payload.class_id}"
              exit(-1)
            end
          end

          #
          # Starts the interactive Ruby shell for the payload.
          #
          def stat_shell
            log_info "Launched payload #{@payload.class_id}"

            RubyShell.start(name: @payload.class.name, context: @payload)
          end

        end
      end
    end
  end
end
