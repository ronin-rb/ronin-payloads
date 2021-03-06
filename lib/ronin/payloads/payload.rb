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

require 'ronin/payloads/exceptions/unknown_helper'
require 'ronin/model/targets_arch'
require 'ronin/model/targets_os'
require 'ronin/extensions/kernel'

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
    # # Metadata
    #
    # A {Payload} is described via metadata, which is cached into the
    # Ronin Database. The cacheable metadata must be defined within a
    # `cache` block, so that the metadata is set only before the payload
    # is cached:
    #
    #     cache do
    #       self.name = 'BindShell payload'
    #       self.version = '0.1'
    #       self.description = %{
    #         An assembly Bind Shell payload, which binds a shell to a
    #         given port.
    #       }
    #
    #       # ...
    #     end
    #
    # ## License
    #
    # A {Payload} may associate with a specific software license using the
    # `licensed_under` method:
    #
    #     cache do
    #       # ...
    #
    #       licensed_under :cc_sa_by
    #     end
    #
    # ## Authors
    #
    # A {Payload} may have one or more authors which contributed to the
    # payload, using the `author` method:
    #
    #     cache do
    #       # ...
    #
    #       author name: 'evoltech', organization: 'HackBloc'
    #       author name: 'postmodern', organization: 'SophSec'
    #     end
    #
    # ## Targeting
    #
    # A {Payload} may target a specific Architecture or Operating System.
    # Targetting information can be set using the `arch` and `os!`
    # methods.
    #
    #     cache do
    #       # ...
    #
    #       arch! :i686
    #       os! name: 'Linux'
    #     end
    #
    # # Methods
    #
    # The functionality of a {Payload} is defined by three main methods:
    #
    # * `build` - Handles building the payload.
    # * `test` - Optional method which handles testing a built payload.
    # * `deploy` - Handles deploying a built and verified payload against a
    #   host.
    # * `evacuate` - Handles cleaning up after a deployed payload.
    #
    # The `build`, `test`, `deploy`, `evacuate` methods can be invoked
    # individually using the `build!`, `test!`, `deploy!`, `evacuate!`
    # methods, respectively.
    #
    # # Exploit/Payload Coupling
    # 
    # When an exploit is coupled with a {Payload}, the {#exploit} method 
    # will contain the coupled exploit. When the payload is built
    # along with the exploit, it will receive the same options given to
    # the exploit.
    #
    # # Payload Chaining
    #
    # All {Payload} classes include the {HasPayload} module, which allows
    # another payload to be chained together with a {Payload}.
    #
    # To chain a cached payload, from the Ronin Database, simply use the
    # `use_payload!` method:
    #
    #     payload.use_payload!(:name.like '%Bind Shell%')
    #
    # In order to chain a payload, loaded directly from a file, call the 
    # `use_payload_from!` method:
    #
    #     payload.use_payload_from!('path/to/my_payload.rb')
    #
    class Payload

      include Model::TargetsArch
      include Model::TargetsOS

      # Primary key of the payload
      property :id, Serial

      # The exploit to deploy with
      attr_accessor :exploit

      # The raw payload
      attr_accessor :raw_payload

      #
      # Creates a new Payload object.
      #
      # @param [Array] attributes
      #   Additional attributes to initialize the payload with.
      #
      def initialize(attributes={})
        super(attributes)
      end

      #
      # Builds the payload.
      #
      # @param [Hash] options
      #   Additional options to build the payload with and use as
      #   parameters.
      #
      # @yield [payload]
      #   If a block is given, it will be yielded the result of the
      #
      # @yieldparam [Payload] payload
      #   The built payload.
      #
      # @note
      #   Sets the `@raw_payload` instance variable to an empty String,
      #   before building the payload.
      #
      def build!(options={},&block)
        @raw_payload = ''

        if @payload.respond_to?(:build!)
          @payload.build!(options)
        end

        super(options,&block)
      end

    end
  end
end
