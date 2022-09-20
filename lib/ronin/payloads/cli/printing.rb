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
          if    defined?(HTMLPayload) && payload_class < HTMLPayload
            'HTML'
          elsif defined?(XMLPayload) && payload_class < XMLPayload
            'XML'
          elsif defined?(SQLPayload) && payload_class < SQLPayload
            'SQL'
          elsif defined?(ShellPayload) && payload_class < ShellPayload
            'shell'
          elsif defined?(PowerShellPayload) && payload_class < PowerShellPayload
            'PowerShell'
          elsif defined?(CPayload) && payload_class < CPayload
            'C'
          elsif defined?(JavaPayload) && payload_class < JavaPayload
            'Java'
          elsif defined?(ColdFusionPayload) && payload_class < ColdFusionPayload
            'ColdFusion'
          elsif defined?(PHPPayload) && payload_class < PHPPayload
            'PHP'
          elsif defined?(NodeJSPayload) && payload_class < NodeJSPayload
            if defined?(Mixins::TypeScript) &&
               payload_class.include?(Mixins::TypeScript)
              'Node.js (TypeScript)'
            else
              'Node.js'
            end
          elsif defined?(JavaScriptPayload) && payload_class < JavaScriptPayload
            if defined?(Mixins::TypeScript) &&
               payload_class.include?(Mixins::TypeScript)
              'JavaScript (TypeScript)'
            else
              'JavaScript'
            end
          elsif defined?(BinaryPayload) && payload_class < BinaryPayload
            if defined?(ShellcodePayload) && payload_class < ShellcodePayload
              'shellcode'
            elsif defined?(ASMPayload) && payload_class < ASMPayload
              'ASM'
            else
              'binary'
            end
          else
            'custom'
          end
        end
      end
    end
  end
end
