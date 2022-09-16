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
require 'ronin/payloads/cli/console'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Start an interactive ruby console.
        #
        # ## Usage
        #
        #     ronin-payloads console [options]
        #
        # ## Options
        #
        #     -h, --help                       Print help information
        #
        class Console < Command

          description "Start an interactive ruby console"

          man_page 'ronin-payloads-console.1'

          #
          # Starts the `ronin-payloads console` command.
          #
          def run
            require 'ronin/payloads'
            CLI::Console.start
          end

        end
      end
    end
  end
end
