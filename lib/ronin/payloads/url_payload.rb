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

require_relative 'payload'

module Ronin
  module Payloads
    #
    # Represents a payload which is hosted publicly at a specified URL.
    #
    # ## Example
    #
    #     class MyHostedPayload < URLPayload
    #
    #       url 'https://evil.com/downloads/my_payload'
    #
    #     end
    #
    class URLPayload < Payload

      #
      # Gets or sets the URL for the payload.
      #
      # @param [String, nil] new_url
      #   The new URL to set.
      #
      # @return [String]
      #   The URL for the payload.
      #
      # @raise [NotImplementedError]
      #   The payload class did not define a {url}.
      #
      def self.url(new_url=nil)
        if new_url
          @url = new_url
        else
          @url || if superclass < URLPayload
                    superclass.url ||
                      raise(NotImplementedError,"#{self} did not define a url")
                  end
        end
      end

      #
      # Returns the type or kind of payload.
      #
      # @return [Symbol]
      #
      # @note
      #   This is used internally to map an payload class to a printable type.
      #
      # @api private
      #
      def self.payload_type
        :url_payload
      end

      #
      # Builds the URL payload.
      #
      def build
        @payload = self.class.url
      end

    end
  end
end
