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

require 'ronin/payloads/registry'
require 'ronin/payloads/exceptions'
require 'ronin/payloads/encoders/pipeline'

require 'ronin/core/module_registry'
require 'ronin/repos/modules_dir'
require 'ronin/core/metadata/module_name'
require 'ronin/core/metadata/authors'
require 'ronin/core/metadata/summary'
require 'ronin/core/metadata/description'
require 'ronin/core/metadata/references'
require 'ronin/core/params/mixin'

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
    #         end
    #       end
    #     end
    #
    class Payload

      include Core::ModuleRegistry
      include Repos::ModulesDir
      include Core::Metadata::ModuleName
      include Core::Metadata::Authors
      include Core::Metadata::Summary
      include Core::Metadata::Description
      include Core::Metadata::References
      include Core::Params::Mixin

      modules_dir 'modules'
      repo_modules_dir 'payloads'

      #
      # Registers the payload with {Payloads}.
      #
      # @param [String] name
      #   The module name for the payload.
      #
      # @example
      #   register 'shellcode/x86_64/linux/binsh'
      #
      # @note The given name _must_ match the file name.
      #
      def self.register(name)
        module_name(name)
        Payloads.register_module(name,self)
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

        @encoders = Encoders::Pipeline.new()

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
      # Builds the payload.
      #
      # @abstract
      #
      def build
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
      # @return [String]
      #   The built payload.
      #
      # @note This method will return a new String each time it is called.
      #
      # @see #build
      #
      def build_payload
        @payload = nil
        build
        return @payload
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
        unless built?
          build

          unless built?
            raise(PayloadNotBound,"the payload was not built for some reason: #{self.inspect}")
          end
        end

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
        built_payload
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
      # Place holder method that s called before the payload is launched.
      #
      # @abstract
      #
      def prelaunch
      end

      #
      # Place holder method that launches the payload.
      #
      # @abstract
      #
      def launch
      end

      #
      # Place holder method that cleans up after the payload has deployed.
      #
      # @abstract
      #
      def cleanup
      end

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

    end
  end
end
