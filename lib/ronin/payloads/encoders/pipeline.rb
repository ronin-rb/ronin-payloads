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

require 'ronin/payloads/encoders/exceptions'

module Ronin
  module Payloads
    module Encoders
      #
      # Represents a pipeline of payload encoders.
      #
      # @api semipublic
      #
      # @since 1.0.0
      #
      class Pipeline

        # The encoders in the pipeline.
        #
        # @return [Array<Encoder>]
        attr_reader :encoders

        #
        # Initializes the encoder pipeline.
        #
        # @param [Array<Encoder>] encoders
        #   Optional encoders to pre-populate the encoder pipeline with.
        #
        def initialize(encoders=[])
          @encoders = encoders
        end

        #
        # Adds a new encoder to the encoder pipeline.
        #
        # @param [Encoder] new_encoder
        #   The new encoder to add.
        #
        # @return [self]
        #
        def <<(new_encoder)
          @encoders << new_encoder
          return self
        end

        #
        # Determines whether the pipeline is empty and has no encoders in it.
        #
        # @return [Boolean]
        #
        def empty?
          @encoders.empty?
        end

        #
        # Enumerates over each encoder in the pipeline.
        #
        # @yield [encoder]
        #   If a block is given, it will be passed each ecoder in the pipeline.
        #
        # @yieldparam [Encoder] encoder
        #   An encoder in the pipeline.
        #
        # @return [Enumerator]
        #   If a block is not given, then an Enumerator will be returned.
        #
        def each(&block)
          @encoders.each(&block)
        end

        #
        # Fetches an encoder at the given index or by it's module name.
        #
        # @param [Integer, String] name_or_index
        #   The index or the encoder's module name to look up.
        #
        # @return [Encoder, nil]
        #   The encoder at the given index or with the matching module name.
        #
        def [](name_or_index)
          case name_or_index
          when String
            name = name_or_index

            @encoders.find { |encoder| encoder.module_name == name }
          else
            index = name_or_index

            @encoders[index]
          end
        end

        #
        # Encodes the payload using the encoder pipeline.
        #
        # @param [String] payload
        #   The unencoded payload.
        #
        # @return [String]
        #   The fully encoded payload.
        #
        # @raise [BadEncoder]
        #   One of the encoders in the pipeline did not return a value.
        #
        def encode(payload)
          encoded_payload = payload

          @encoders.each do |encoder|
            unless (encoded_payload = encoder.encode(encoded_payload))
              raise(BadEncoder,"no result was returned by the encoder: #{encoder.inspect}")
            end
          end

          return encoded_payload
        end

      end
    end
  end
end
