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

module Ronin
  module Payloads
    class CLI
      module Generator
        # Mapping of payload types and their file/class names.
        PAYLOAD_TYPES = {
          payload: {
            file:  'payload',
            class: 'Payload'
          },

          asm: {
            file:  'asm_payload',
            class: 'ASMPayload'
          },

          shellcode: {
            file:  'shellcode_payload',
            class: 'ShellcodePayload'
          },

          c: {
            file:  'c_payload',
            class: 'CPayload'
          },

          go: {
            file:  'go_payload',
            class: 'GoPayload'
          },

          rust: {
            file:  'rust_payload',
            class: 'RustPayload'
          },

          shell: {
            file:  'shell_payload',
            class: 'ShellPayload'
          },

          powershell: {
            file:  'powershell_payload',
            class: 'PowerShellPayload'
          },

          html: {
            file:  'html_payload',
            class: 'HTMLPayload'
          },

          javascript: {
            file:  'javascript_payload',
            class: 'JavaScriptPayload'
          },

          typpescript: {
            file:  'typescript_payload',
            class: 'TypeScriptPayload'
          },

          java: {
            file:  'java_payload',
            class: 'JavaPayload'
          },

          sql: {
            file:  'sql_payload',
            class: 'SQLPayload'
          },

          php: {
            file:  'php_payload',
            class: 'PHPPayload'
          },

          python: {
            file:  'python_payload',
            class: 'PythonPayload'
          },

          ruby: {
            file:  'ruby_payload',
            class: 'RubyPayload'
          },

          nodejs: {
            file:  'node_js_payload',
            class: 'NodeJSPayload'
          }
        }
      end
    end
  end
end
