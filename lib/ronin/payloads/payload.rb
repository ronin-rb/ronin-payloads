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

require_relative 'registry'
require_relative 'exceptions'
require_relative 'encoders/encoder'
require_relative 'encoders/pipeline'

require 'ronin/core/metadata/id'
require 'ronin/core/metadata/authors'
require 'ronin/core/metadata/summary'
require 'ronin/core/metadata/description'
require 'ronin/core/metadata/references'
require 'ronin/core/params/mixin'
require 'ronin/support/cli/printing'

require 'set'

module Ronin
  module Payloads
    #
    # The {Payload} class allows for describing payloads, which are
    # delivered via exploits, purely in Ruby. Payloads contain metadata
    # about the payload and methods which define the functionality of the
    # payload. Payloads may also be coupled with exploits, or chained
    # together with other payloads.
    #
    # ## Payload API Methods
    #
    # * {Payload#initialize initialize} - Initializes a new instance of the
    #   payload.
    # * {Payload#build build} - contains the logic to build the payload. The
    #   built payload must be stored in the `@payload` instance variable.
    # * {Payload#prelaunch prelaunch} - contains additional logic that runs
    #   before the payload has been launched by the exploit.
    # * {Payload#postlaunch postlaunch} - contains additional logic that runs
    #   after the payload has been launched by the exploit.
    # * {Payload#cleanup cleanup} - contains additional logic to cleanup or
    #   shutdown the payload.
    #
    # ## Example
    #
    #     module Ronin
    #       module Payloads
    #         class MyPayload < Payload
    #
    #           register 'my_payload'
    #
    #           summary 'My first payload'
    #           description <<~EOS
    #             This is my first payload.
    #             Bla bla bla bla.
    #           EOS
    #
    #           author 'John Smith'
    #           author 'John Smith', email: '...', twitter: '...'
    #
    #           param :foo, desc: 'Simple param'
    #           param :bar, Integer, desc: 'A param iwth a typo'
    #
    #           def build
    #             @payload = "..."
    #           end
    #
    #           def prelaunch
    #             # ...
    #           end
    #
    #           def postlaunch
    #             # ...
    #           end
    #
    #           def cleanup
    #             # ...
    #           end
    #
    #         end
    #       end
    #     end
    #
    class Payload

      include Core::Metadata::ID
      include Core::Metadata::Authors
      include Core::Metadata::Summary
      include Core::Metadata::Description
      include Core::Metadata::References
      include Core::Params::Mixin
      include Support::CLI::Printing

      #
      # Registers the payload with {Payloads}.
      #
      # @param [String] payload_id
      #   The payload's ID.
      #
      # @example
      #   register 'shellcode/x86_64/linux/binsh'
      #
      # @note The given `id` _must_ match the file name.
      #
      def self.register(payload_id)
        id(payload_id)
        Payloads.register(payload_id,self)
      end

      #
      # Gets or sets the payload encoder base class that is compatible with the
      # payload.
      #
      # @param [Class<Encoders::Encoder>, nil] new_encoder_class
      #   The optional new payload encoder base class to set.
      #
      # @return [Class<Encoders::Encoder>]
      #   The exploit's compatible payload encoder base class.
      #
      def self.encoder_class(new_encoder_class=nil)
        if new_encoder_class
          @encoder_class = new_encoder_class
        else
          @encoder_class ||= if superclass < ClassMethods
                               superclass.encoder_class
                             else
                               Encoders::Encoder
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
        :payload
      end

      # The built payload
      attr_reader :payload

      # The payload's encoder pipeline.
      #
      # @return [Encoders::Pipeline]
      attr_reader :encoders

      #
      # Initializes the payload.
      #
      # @param [Array<Encoders::Encoder>, nil] encoders
      #   The optional list of payload encoders to use.
      #
      # @raise [IncompatibleEncoder]
      #   One of the encoders in `encoders:` was not compatible with the
      #   payload's {encoder_class}.
      #
      def initialize(encoders: nil, **kwargs)
        super(**kwargs)

        @encoders = Encoders::Pipeline.new

        if encoders
          encoders.each do |encoder|
            unless encoder.kind_of?(self.class.encoder_class)
              raise(IncompatibleEncoder,"encoder for payload #{self.class} was not of type #{self.class.encoder_class}: #{encoder.inspect}")
            end

            @encoders << encoder
          end
        end
      end

      #
      # Validates that the payload is ready to be built.
      #
      # @raise [Ronin::Core::Params::RequiredParam]
      #   One of the required params was not set.
      #
      # @raise [ValidationError]
      #   Another payload validation error occurred.
      #
      # @api semipublic
      #
      def perform_validate
        validate_params
        @encoders.validate
        validate
      end

      #
      # Determines whether the payload was built.
      #
      # @return [Boolean]
      #
      def built?
        !(@payload.nil? || @payload.empty?)
      end

      #
      # Builds the payload.
      #
      # @see #build
      #
      # @api semipublic
      #
      def perform_build
        @payload = nil

        build

        unless built?
          raise(PayloadNotBuilt,"the payload was not built for some reason: #{inspect}")
        end
      end

      #
      # The built payload String.
      #
      # @return [String]
      #   The built payload String.
      #
      # @note This method will lazy-build the payload if unbuilt.
      #
      def built_payload
        perform_build unless built?

        return @payload
      end

      #
      # Forcibly rebuilds the payload.
      #
      # @return [String]
      #   The re-built payload String.
      #
      def rebuild_payload
        @payload = nil
        perform_build
      end

      #
      # Encodes the built payload.
      #
      # @return [String]
      #   The encoded payload String.
      #
      # @note
      #   This method will return a new, potentially different, String each
      #   time.
      #
      def encode_payload
        @encoders.encode(built_payload)
      end

      #
      # The encoded payload.
      #
      # @return [String]
      #   The encoded payload String.
      #
      # @note
      #   This method will lazy build then lazy encode the payload and save the
      #   result.
      #
      # @see #encode_payload
      #
      def encoded_payload
        @encoded_payload ||= encode_payload
      end

      #
      # Forcibly re-encodes the payload.
      #
      # @return [String]
      #   The re-encoded payload String.
      #
      # @note
      #   This will re-encode the built payload and update {#encoded_payload}.
      #
      # @see #encode_payload
      #
      def reencode_payload
        @encoded_payload = encode_payload
      end

      #
      # Performs the prelaunch step.
      #
      # @see #prelaunch
      #
      # @api semipublic
      #
      def perform_prelaunch
        prelaunch
      end

      #
      # Performs the post-launch step.
      #
      # @see #postlaunch
      #
      # @api semipublic
      #
      def perform_postlaunch
        postlaunch
      end

      #
      # Performs the cleanup step.
      #
      # @see #cleanup
      #
      # @api semipublic
      #
      def perform_cleanup
        cleanup
        @payload = nil
      end

      #
      # @group String Methods
      #

      #
      # The number of characters in the payload.
      #
      # @return [Integer]
      #
      def length
        encoded_payload.length
      end

      #
      # The size of the payload in bytes.
      #
      # @return [Integer]
      #
      def bytesize
        encoded_payload.bytesize
      end

      alias size bytesize

      #
      # Converts the payload into a String.
      #
      # @return [String]
      #   The built and encoded payload.
      #
      # @see #encoded_payload
      #
      def to_s
        encoded_payload
      end

      alias to_str to_s

      #
      # @group Payload API Methods
      #

      #
      # Place holder method for additional validation logic.
      #
      # @api public
      #
      # @abstract
      #
      def validate
      end

      #
      # Builds the payload.
      #
      # @abstract
      #
      def build
      end

      #
      # Placeholder method that runs before the payload is launched by the
      # exploit.
      #
      # @abstract
      #
      def prelaunch
      end

      #
      # Placeholder method that runs after the payload is launched by the
      # exploit.
      #
      # @abstract
      #
      def postlaunch
      end

      #
      # Placeholder method to clean up the payload.
      #
      # @abstract
      #
      def cleanup
      end

    end
  end
end
