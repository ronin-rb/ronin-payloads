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

require_relative '../../command_payload'

module Ronin
  module Payloads
    module CMD
      #
      # A simple `ping -c 4 127.0.0.1` command.
      #
      # @since 0.2.0
      #
      class Ping < CommandPayload

        register 'cmd/ping'

        param :host, String, default: '127.0.0.1',
                             desc:    'The host to ping'

        param :count, Integer, default: 4,
                               desc:    'The number of packets to send'

        #
        # Builds the `ping` command.
        #
        def build
          @payload = "ping -c #{params[:count]} #{params[:host]}"
        end

      end
    end
  end
end
