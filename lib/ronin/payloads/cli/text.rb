# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/core/cli/text/params'

module Ronin
  module Payloads
    class CLI
      #
      # Methods for generating display text.
      #
      # @since 0.3.0
      #
      module Text
        include Core::CLI::Text::Params

        # Known payload types and their display names.
        PAYLOAD_TYPE_NAMES = {
          payload: 'Custom',

          binary:    'Binary',
          asm:       'ASM',
          shellcode: 'Shellcode',

          c:    'C',
          go:   'Go',
          rust: 'Rust',

          java:   'Java',
          groovy: 'Groovy',

          command:         'Command',
          shell_command:   'Shell Command',
          windows_command: 'Windows Command',
          shell:           'Shell',
          powershell:      'PowerShell',

          coldfusion: 'ColdFusion',
          jsp:        'JSP',
          perl:       'Perl',
          php:        'PHP',
          python:     'Python',
          ruby:       'Ruby',

          javascript: 'JavaScript',
          node_js:    'Node.js',
          nashorn:    'Nashorn',

          sql:  'SQL',
          html: 'HTML',
          xml:  'XML'
        }

        #
        # Returns the payload type display name for the payload class.
        #
        # @param [Class<Payload>] payload_class
        #   The payload class.
        #
        # @return [String]
        #   The payload type display name (ex: 'ASM' or 'shellcode').
        #
        def payload_type_name(payload_class)
          PAYLOAD_TYPE_NAMES.fetch(payload_class.payload_type,'Unknown')
        end

        #
        # Builds an example `ronin-payloads build` command for the payload.
        #
        # @param [Class<Payload>] payload_class
        #   The payload class.
        #
        # @param [String, nil] file
        #   The optional file that the payload was loaded from.
        #
        # @return [String]
        #   The example `ronin-payloads build` command.
        #
        def example_payload_command(payload_class, file: nil)
          command = ['ronin-payloads', 'build']

          if file
            command << '-f' << file
          else
            command << payload_class.id
          end

          payload_class.params.each_value do |param|
            if param.required? && !param.default
              command << '-p' << "#{param.name}=#{param_usage(param)}"
            end
          end

          return command.join(' ')
        end
      end
    end
  end
end
