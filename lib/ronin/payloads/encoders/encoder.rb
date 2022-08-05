#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-payloads.
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

require 'ronin/core/metadata/module_name'
require 'ronin/core/metadata/authors'
require 'ronin/core/metadata/summary'
require 'ronin/core/metadata/description'
require 'ronin/core/metadata/references'
require 'ronin/core/params/mixin'

module Ronin
  module Payloads
    module Encoders
      #
      # Base-class for all other payload encoders.
      #
      # ## Example
      #
      #     module Ronin
      #       module Payloads
      #         module Encoders
      #           class MyEncoder < Encoder
      #             
      #           end
      #         end
      #       end
      #     end
      #
      # @since 1.0.0
      #
      # @api public
      #
      class Encoder

        include Core::Metadata::ModuleName
        include Core::Metadata::Authors
        include Core::Metadata::Summary
        include Core::Metadata::Description
        include Core::Metadata::References
        include Core::Params::Mixin

        #
        # Default method which will encode data.
        #
        # @param [String] data
        #   The data to be encoded.
        #
        # @return [String]
        #   The encoded data.
        #
        # @abstract
        #
        def encode(data)
          raise(NotImplementedError,"#{self.class}##{__method__} was not implemented")
        end

      end
    end
  end
end
