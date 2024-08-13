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

module Ronin
  module Payloads
    class CLI
      #
      # Common methods for printing payload metadata.
      #
      module Printing
        # Known payload types and their printable names.
        PAYLOAD_TYPES = {
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
        # Returns the printable payload type for the payload class.
        #
        # @param [Class<Payload>] payload_class
        #   The payload class.
        #
        # @return [String]
        #   The printable payload type (ex: 'ASM' or 'shellcode').
        #
        def payload_type(payload_class)
          PAYLOAD_TYPES.fetch(payload_class.payload_type,'Unknown')
        end
      end
    end
  end
end
