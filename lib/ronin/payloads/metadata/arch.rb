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

module Ronin
  module Payloads
    module Metadata
      #
      # Metadata mixin that allows a payload to define which architecture it
      # specifically targets.
      #
      module Arch
        #
        # Adds an {ClassMethods#arch arch} metadata attribute to the payload.
        #
        # @param [Class<Ronin::Payloads::Payload>] payload
        #   The payload class that is including {Metadata::Arch}.
        #
        # @api private
        #
        def self.included(payload)
          payload.extend ClassMethods
        end

        module ClassMethods
          #
          # Gets or sets the payload's architecture.
          #
          # @param [:x86, :x86_64, :ia64, :amd64, :ppc, :ppc64, :mips, :mips_le, :mips_be, :mips64, :mips64_le, :mips64_be, :arm, :arm_le, :arm_be, :arm64, :arm64_le, :arm64_be, nil] new_arch
          #   The optional new architecture to set.
          #
          # @return [:x86, :x86_64, :ia64, :amd64, :ppc, :ppc64, :mips, :mips_le, :mips_be, :mips64, :mips64_le, :mips64_be, :arm, :arm_le, :arm_be, :arm64, :arm64_le, :arm64_be, nil]
          #   The payload's architecture.
          #
          # @example
          #   arch :x86_64
          #
          # @api public
          #
          def arch(new_arch=nil)
            if new_arch
              @arch = new_arch
            else
              @arch ||= if superclass.kind_of?(ClassMethods)
                          superclass.arch
                        end
            end
          end
        end

        #
        # The architecture that the payload targets.
        #
        # @return [:x86, :x86_64, :ia64, :amd64, :ppc, :ppc64, :mips, :mips_le, :mips_be, :mips64, :mips64_le, :mips64_be, :arm, :arm_le, :arm_be, :arm64, :arm64_le, :arm64_be, nil]
        #   The payload's architecture.
        #
        # @see ClassMethods#arch
        #
        # @api public
        #
        def arch
          self.class.arch
        end
      end
    end
  end
end
