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

require 'ronin/payloads/exceptions'

module Ronin
  module Payloads
    module Encoders
      #
      # Base class for all encoder errors.
      #
      class EncoderError < PayloadError
      end

      #
      # Indicates a validation error during the validation phase of the encoder.
      #
      class ValidationError < EncoderError
      end

      #
      # Indicates the encoder did not actually encode the given data.
      #
      class BadEncoder < EncoderError
      end
    end
  end
end
