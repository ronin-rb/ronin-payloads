# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2023 Hal Brodigan (postmodern.mod3 at gmail.com)
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
require 'ronin/support/binary/ctypes'

module Ronin
  module Payloads
    module Mixins
      #
      # Adds support for packing binary data.
      #
      # @api public
      #
      module Binary
        #
        # Validates that the payload defines an `arch` method and that all
        # required params are set.
        #
        # @raise [ValidationError]
        #   The payload did not define an `arch` method, usually defined by
        #   {Metadata::Arch}.
        #
        # @raise [Ronin::Core::Params::RequiredParam]
        #   One of the required params was not set.
        #
        # @api semipublic
        #
        def perform_validate
          unless respond_to?(:arch)
            raise(ValidationError,"payload #{self.class} did not include Ronin::Payloads::Metadata::Arch")
          end

          unless arch
            raise(ValidationError,"payload #{self.class} did not include define an architecture")
          end

          super()
        end

        #
        # The target platform.
        #
        # @return [Ronin::Support::Binary::CTypes,
        #          Ronin::Support::Binary::CTypes::LittleEndian,
        #          Ronin::Support::Binary::CTypes::BigEndian,
        #          Ronin::Support::Binary::CTypes::Network,
        #          Ronin::Support::Binary::CTypes::Arch::ARM,
        #          Ronin::Support::Binary::CTypes::Arch::ARM::BigEndian,
        #          Ronin::Support::Binary::CTypes::Arch::ARM64,
        #          Ronin::Support::Binary::CTypes::Arch::ARM64::BigEndian,
        #          Ronin::Support::Binary::CTypes::Arch::MIPS,
        #          Ronin::Support::Binary::CTypes::Arch::MIPS::LittleEndian,
        #          Ronin::Support::Binary::CTypes::Arch::MIPS64,
        #          Ronin::Support::Binary::CTypes::Arch::MIPS64::LittleEndian,
        #          Ronin::Support::Binary::CTypes::Arch::PPC,
        #          Ronin::Support::Binary::CTypes::Arch::PPC64,
        #          Ronin::Support::Binary::CTypes::Arch::X86,
        #          Ronin::Support::Binary::CTypes::Arch::X86_64,
        #          Ronin::Support::Binary::CTypes::OS]
        #
        def platform
          @platform ||= Support::Binary::CTypes.platform(
                          arch: arch,
                          os:   (os if kind_of?(Metadata::OS))
                        )
        end

        #
        # Packs a binary value for the given type.
        #
        # @param [Symbol] type
        #   The type name to pack for.
        #
        # @param [Integer, Float, String] value
        #   The value to pack.
        #
        # @return [String]
        #   The packed value.
        #
        def pack(type,value)
          platform[type].pack(value)
        end
      end
    end
  end
end
