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
        #     -t asm|shellcode|c|shell|powershell|html|javascript|java|sql|php|nodejs,
        #         --type                       The type for the new payload
        #     -S, --summary TEXT               One sentence summary for the payload
        #     -D, --description TEXT           Longer description for the payload
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     FILE                             The path to the new payload file.
        #
        class New < Command

          include Core::CLI::Generator

          PAYLOAD_TYPES = {
            nil => {
              class_file: 'payload',
              class_name: 'Payload'
            },

            asm: {
              class_file: 'asm_payload',
              class_name: 'ASMPayload'
            },

            shellcode: {
              class_file: 'shellcode_payload',
              class_name: 'ShellcodePayload'
            },

            c: {
              class_file: 'c_payload',
              class_name: 'CPayload'
            },

            shell: {
              class_file: 'shell_payload',
              class_name: 'ShellPayload'
            },

            powershell: {
              class_file: 'powershell_payload',
              class_name: 'PowerShellPayload'
            },

            html: {
              class_file: 'html_payload',
              class_name: 'HTMLPayload'
            },

            javascript: {
              class_file: 'javascript_payload',
              class_name: 'JavaScriptPayload'
            },

            java: {
              class_file: 'java_payload',
              class_name: 'JavaPayload'
            },

            sql: {
              class_file: 'sql_payload',
              class_name: 'SQLPayload'
            },

            php: {
              class_file: 'php_payload',
              class_name: 'PHPPayload'
            },

            nodejs: {
              class_file: 'node_js_payload',
              class_name: 'NodeJSPayload'
            }
          }

          template_dir File.join(ROOT,'data','templates')

          usage '[options] FILE'

          option :type, short: '-t',
                        value: {
                          type: [:asm, :shellcode, :c, :shell, :powershell, :html, :javascript, :java, :sql, :php, :nodejs]
                        },
                        desc: 'The type for the new payload'

          option :summary, short: '-S',
                           value: {
                             type: String,
                             usage: 'TEXT'
                           },
                           desc: 'One sentence summary for the payload'

          option :description, short: '-D',
                               value: {
                                 type: String,
                                 usage: 'TEXT'
                               },
                               desc: 'Longer description for the payload'

          argument :path, desc: 'The path to the new payload file'

          description 'Creates a new payload file'

          man_page 'ronin-payloads-new.1'

          #
          # Runs the `ronin-payloads new` command.
          #
          # @param [String] file
          #   The path to the new payload file.
          #
          def run(file)
            @file_name  = File.basename(file,File.extname(file))
            @class_name = CommandKit::Inflector.camelize(@file_name)

            payload_type        = PAYLOAD_TYPES.fetch(options[:type])
            @payload_class_file = payload_type.fetch(:class_file)
            @payload_class_name = payload_type.fetch(:class_name)

            @author_name  = Core::Git.user_name || ENV['USERNAME']
            @author_email = Core::Git.user_email

            @summary     = options[:summary]
            @description = options[:description]

            erb "payload.rb.erb", file
            chmod '+x', file
          end

        end
      end
    end
  end
end
