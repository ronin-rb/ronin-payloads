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

require 'ronin/payloads/binary_payload'
require 'ronin/payloads/asm_payload'
require 'ronin/payloads/shellcode_payload'
require 'ronin/payloads/c_payload'
require 'ronin/payloads/java_payload'
require 'ronin/payloads/javascript_payload'
require 'ronin/payloads/node_js_payload'
require 'ronin/payloads/shell_payload'
require 'ronin/payloads/powershell_payload'
require 'ronin/payloads/coldfusion_payload'
require 'ronin/payloads/php_payload'
require 'ronin/payloads/sql_payload'
require 'ronin/payloads/html_payload'
require 'ronin/payloads/xml_payload'
require 'ronin/payloads/mixins/typescript'

module Ronin
  module Payloads
    class CLI
      module Printing
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
          if    payload_class < HTMLPayload       then 'HTML'
          elsif payload_class < XMLPayload        then 'XML'
          elsif payload_class < SQLPayload        then 'SQL'
          elsif payload_class < ShellPayload      then 'shell'
          elsif payload_class < PowerShellPayload then 'PowerShell'
          elsif payload_class < CPayload          then 'C'
          elsif payload_class < JavaPayload       then 'Java'
          elsif payload_class < ColdFusionPayload then 'ColdFusion'
          elsif payload_class < PHPPayload        then 'PHP'
          elsif payload_class < NodeJSPayload
            if payload_class.include?(Mixins::TypeScript)
              'Node.js (TypeScript)'
            else
              'Node.js'
            end
          elsif payload_class < JavaScriptPayload
            if payload_class.include?(Mixins::TypeScript)
              'JavaScript (TypeScript)'
            else
              'JavaScript'
            end
          elsif payload_class < BinaryPayload
            if    payload_class < ShellcodePayload then 'shellcode'
            elsif payload_class < ASMPayload       then 'ASM'
            else                                        'binary'
            end
          else
            'custom'
          end
        end
      end
    end
  end
end
