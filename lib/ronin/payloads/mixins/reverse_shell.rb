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
    module Mixins
      #
      # Common params and methods for reverse shell payloads.
      #
      module ReverseShell
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
                                       desc:     'The host to connect back to'

          payload.param :port, Integer, required: true,
                                        desc:     'The port to connect back to'
        end
      end
    end
  end
end
