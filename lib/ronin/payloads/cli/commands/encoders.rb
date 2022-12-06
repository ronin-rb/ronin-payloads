# frozen_string_literal: true
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
require 'ronin/payloads/encoders/registry'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Lists available anecoders or a specific encoder.
        #
        # ## Usage
        #
        #     ronin-payloads encoders [options] [DIR]
        #
        # ## Options
        #
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [DIR]                            The optional directory to list
        #
        class Encoders < Command

          usage '[options] [DIR]'

          argument :dir, required: false,
                         desc:     'The optional directory to list'

          description 'Lists available anecoders or a specific encoder'

          man_page 'ronin-payloads-encoders.1'

          #
          # Runs the `ronin-payloads encoders` command.
          #
          # @param [String, nil] dir
          #   The optional encoder name or directory to list.
          #
          def run(dir=nil)
            files = if dir
                      dir = "#{dir}/" unless name.end_with?('/')

                      Payloads::Encoders.list_files.select do |file|
                        file.start_with?(dir)
                      end
                    else
                      Payloads::Encoders.list_files
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
