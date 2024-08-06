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

require_relative 'registry'

require 'ronin/core/metadata/id'
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
      #     # encoders/my_encoder.rb
      #     module Ronin
      #       module Payloads
      #         module Encoders
      #           class MyEncoder < Encoder
      #
      #             register 'my_encoder'
      #
      #             def encode(data)
      #               return ...
      #             end
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

        include Core::Metadata::ID
        include Core::Metadata::Authors
        include Core::Metadata::Summary
        include Core::Metadata::Description
        include Core::Metadata::References
        include Core::Params::Mixin

        #
        # Registers the encoder with {Encoders}.
        #
        # @param [String] encoder_id
        #   The encoder's `id`.
        #
        # @example
        #   register 'js/eval_base64'
        #
        # @note The given `id` _must_ match the file name.
        #
        def self.register(encoder_id)
          id(encoder_id)
          Encoders.register(encoder_id,self)
        end

        #
        # Validates that all required params have been set.
        #
        # @raise [Ronin::Core::Params::RequiredParam]
        #   One of the required params was not set.
        #
        # @raise [ValidationError]
        #   Another encoder validation error occurred.
        #
        # @api semipublic
        #
        def validate
          validate_params
        end

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
