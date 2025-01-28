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

require_relative 'post_ex'

require 'ronin/post_ex/sessions/reverse_shell'

require 'socket'

module Ronin
  module Payloads
    module Mixins
      #
      # Common params and methods for reverse shell payloads.
      #
      module ReverseShell
        include Mixins::PostEx

        #
        # Adds the `host` and `port` required options to the payload.
        #
        # @param [Class<Payload>] payload
        #   The payload class including {ReverseShell}.
        #
        # @api private
        #
        def self.included(payload)
          payload.param :host, String, required: true,
                                       default:  '0.0.0.0',
                                       desc:     'The host to connect back to'

          payload.param :port, Integer, required: true,
                                        default:  4444,
                                        desc:     'The port to connect back to'
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
        # Opens a server socket using {#host} and {#port}, then performs
        # additional pre-launch steps.
        #
        def perform_prelaunch
          @server = TCPServer.new(host,port)
          @server.listen(1)

          super
        end

        #
        # Waits for an incoming connect on {#host} and {#port}, then performs
        # additional post-launch steps.
        #
        def perform_postlaunch
          print_info "Waiting for connection on #{host}:#{port} ..."
          @session = Ronin::PostEx::Sessions::ReverseShell.new(@server.accept)
          print_info "Accepted connection from #{@session.name}!"

          super
        end

        #
        # Performs additional cleanup steps, then closes any connections and the
        # server socket.
        #
        def perform_cleanup
          super

          if @server
            @server.close
            @server = nil
          end
        end
      end
    end
  end
end
