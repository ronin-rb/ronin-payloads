# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2025 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../command'
require_relative '../../registry'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Lists the available payloads.
        #
        # ## Usage
        #
        #     ronin-payloads list [options] [DIR]
        #
        # ## Options
        #
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [DIR]                            The optional payload directory to list
        #
        class List < Command

          usage '[options] [DIR]'

          argument :dir, required: false,
                         desc:     'The optional payload directory to list'

          description 'Lists the available payloads'

          man_page 'ronin-payloads-list.1'

          #
          # Runs the `ronin-payloads list` command.
          #
          # @param [String, nil] dir
          #   The optional payload directory to list.
          #
          def run(dir=nil)
            files = if dir
                      dir = "#{dir}/" unless dir.end_with?('/')

                      Payloads.list_files.select do |file|
                        file.start_with?(dir)
                      end
                    else
                      Payloads.list_files
                    end

            files.each do |file|
              puts "  #{file}"
            end
          end

        end
      end
    end
  end
end
