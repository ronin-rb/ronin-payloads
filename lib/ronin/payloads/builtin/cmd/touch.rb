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

require 'ronin/payloads/command_payload'

module Ronin
  module Payloads
    module CMD
      #
      # A simple `touch /tmp/pwned` command.
      #
      # @since 0.2.0
      #
      class Touch < CommandPayload

        register 'cmd/touch'

        param :file, String, default: '/tmp/pwned',
                             desc:    'The file to touch'

        #
        # Builds the `touch` command.
        #
        def build
          @payload = "touch #{params[:file]}"
        end

      end
    end
  end
end
