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

require_relative 'payload'
require_relative 'metadata/os'
require_relative 'encoders/command_encoder'

require 'ronin/support/encoding/ruby'

module Ronin
  module Payloads
    #
    # A {Payload} base class that represents generic commands (UNIX or
    # PowerShell).
    #
    class CommandPayload < Payload

      include Metadata::OS

      encoder_class Encoders::CommandEncoder

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
        :command
      end

      #
      # Converts the built command into Ruby code.
      #
      # @return [String]
      #   The Ruby code which executes the command.
      #
      # @api public
      #
      # @since 0.3.0
      #
      def to_ruby
        "system(#{Support::Encoding::Ruby.quote(to_s)})"
      end

      alias to_command to_s

    end
  end
end
