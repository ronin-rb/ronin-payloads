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

require 'socket'

module Ronin
  module Payloads
    module Mixins
      #
      # Common params and methods for bind shell payloads.
      #
      module BindShell
        #
        # Adds the `host` and `port` required options to the payload.
        #
        # @param [Class<Payload>] payload
        #   The payload class including {BindShell}.
        #
        # @api private
        #
        def self.included(payload)
          payload.param :host, String, required: true,
                                       desc:     'The host interface to listen on'

          payload.param :port, Integer, required: true,
                                        desc:     'The port to listen on'
        end

        #
        # The host param value.
        #
        # @return [String]
        #
        def host
          params[:host]
        end

        #
        # The port param value.
        #
        # @return [Integer]
        #
        def port
          params[:port]
        end

        #
        # Connects to the remote bind shell on {#host} and {#port}, then
        # performs additional post-launch steps.
        #
        def perform_postlaunch
          print_info "Connecting to #{host}:#{port} ..."
          @socket = TCPSocket.new(host,port)
          print_info "Connected to #{host}:#{port}!"

          super
        end

        #
        # Performs additional cleanup steps and closes the connection to the
        # remote bind shell.
        #
        def cleanup
          super

          if @socket
            @socket.close
            @socket = nil
          end
        end
      end
    end
  end
end
