#
# Copyright (c) 2021 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# ronin-repos is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-repos is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-repos.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/payloads/cli/command'
require 'ronin/payloads/cli/generator/payload_types'
require 'ronin/payloads/root'

require 'ronin/core/cli/generator'
require 'ronin/core/cli/generator/options/author'
require 'ronin/core/cli/generator/options/summary'
require 'ronin/core/cli/generator/options/description'
require 'ronin/core/cli/generator/options/reference'
require 'ronin/core/git'

require 'command_kit/inflector'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Creates a new payload file.
        #
        # ## Usage
        #
        #     ronin-payload new [options] FILE
        #
        # ## Options
        # 
        #     -t asm|shellcode|c|go|rust|shell|powershell|html|javascript|typescript|java|sql|php|ruby|nodejs,
        #         --type                       The type for the new payload
        #     -a, --author NAME                The name of the author
        #     -e, --author-email EMAIL         The email address of the author
        #     -S, --summary TEXT               One sentence summary
        #     -D, --description TEXT           Longer description
        #     -R, --reference URL              Adds a reference URL
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     FILE                             The path to the new payload file.
        #
        class New < Command

          include Core::CLI::Generator
          include Payloads::CLI::Generator

          template_dir File.join(ROOT,'data','templates')

          usage '[options] FILE'

          option :type, short: '-t',
                        value: {type: PAYLOAD_TYPES.keys},
                        desc: 'The type for the new payload' do |type|
                          @payload_type = PAYLOAD_TYPES.fetch(type)
                        end

          include Core::CLI::Generator::Options::Author
          include Core::CLI::Generator::Options::Summary
          include Core::CLI::Generator::Options::Description
          include Core::CLI::Generator::Options::Reference

          argument :path, desc: 'The path to the new payload file'

          description 'Creates a new payload file'

          man_page 'ronin-payloads-new.1'

          # The references to add to the payload.
          #
          # @return [Array<String>]
          attr_reader :references

          #
          # Initializes the `ronin-payloads new` command.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments.
          #
          def initialize(**kwargs)
            super(**kwargs)

            @payload_type = PAYLOAD_TYPES.fetch(:payload)
          end

          #
          # Runs the `ronin-payloads new` command.
          #
          # @param [String] file
          #   The path to the new payload file.
          #
          def run(file)
            @file_name  = File.basename(file,File.extname(file))
            @class_name = CommandKit::Inflector.camelize(@file_name)

            erb "payload.rb.erb", file
            chmod '+x', file
          end

        end
      end
    end
  end
end
