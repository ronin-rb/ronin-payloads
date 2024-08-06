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

require 'ronin/core/cli/completion_command'

require_relative '../../root'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Manages the shell completion rules for `ronin-payloads`.
        #
        # ## Usage
        #
        #     ronin-payloads completion [options]
        #
        # ## Options
        #
        #         --print                      Prints the shell completion file
        #         --install                    Installs the shell completion file
        #         --uninstall                  Uninstalls the shell completion file
        #     -h, --help                       Print help information
        #
        # ## Examples
        #
        #     ronin-payloads completion --print
        #     ronin-payloads completion --install
        #     ronin-payloads completion --uninstall
        #
        # @since 0.2.0
        #
        class Completion < Core::CLI::CompletionCommand

          completion_file File.join(ROOT,'data','completions','ronin-payloads')

          man_dir File.join(ROOT,'man')
          man_page 'ronin-payloads-completion.1'

          description 'Manages the shell completion rules for ronin-payloads'

        end
      end
    end
  end
end
