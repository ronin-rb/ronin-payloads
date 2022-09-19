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
        #     -t asm|shellcode|c|shell|powershell|html|javascript|typescript|java|sql|php|nodejs,
        #         --type                       The type for the new payload
        #     -a, --author NAME                The name of the author
        #     -e, --author-email EMAIL         The email address of the author
        #     -S, --summary TEXT               One sentence summary for the payload
        #     -D, --description TEXT           Longer description for the payload
        #     -R, --reference URL              Adds a reference to the payload
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

          option :author, short: '-a',
                          value: {
                            type:  String,
                            usage: 'NAME',
                            default: Core::Git.user_name || ENV['USERNAME']
                          },
                          desc: 'The name of the author' do |author|
                            @author_name = author
                          end

          option :author_email, short: '-e',
                                value: {
                                  type:  String,
                                  usage: 'EMAIL',
                                  default: Core::Git.user_email
                                },
                                desc: 'The email address of the author' do |email|
                                  @author_email = email
                                end

          option :summary, short: '-S',
                           value: {
                             type: String,
                             usage: 'TEXT'
                           },
                           desc: 'One sentence summary for the payload' do |text|
                             @summary = text
                           end

          option :description, short: '-D',
                               value: {
                                 type: String,
                                 usage: 'TEXT'
                               },
                               desc: 'Longer description for the payload' do |text|
                                 @description = text
                               end

          option :reference, short: '-R',
                             value: {
                               type: String,
                               usage: 'URL'
                             },
                             desc: 'Adds a reference to the payload' do |url|
                               @references << url
                             end

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
            @references   = []
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
