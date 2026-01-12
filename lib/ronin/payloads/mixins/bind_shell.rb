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

require_relative 'post_ex'

require 'ronin/post_ex/sessions/bind_shell'

module Ronin
  module Payloads
    module Mixins
      #
      # Common params and methods for bind shell payloads.
      #
      module BindShell
        include Mixins::PostEx

        #
        # Adds the `host` and `port` required options to the payload.
        #
        # @param [Class<Payload>] payload
        #   The payload class including {BindShell}.
        #
        # @api private
        #
        def self.included(payload)
          payload.param :host, String, default: '0.0.0.0',
                                       desc:    'The host to connect to'

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
          @session = Ronin::PostEx::Sessions::BindShell.connect(host,port)
          print_info "Connected to #{host}:#{port}!"

          super
        end
      end
    end
  end
end
