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

module Ronin
  module Payloads
    module Metadata
      #
      # Metadata mixin that allows a payload to define which
      # Operating System (OS) it specifically targets.
      #
      # @api private
      #
      module OS
        #
        # Adds an {ClassMethods#os os} and {ClassMethods#os_version os_version}
        # metadata attributes to the payload.
        #
        # @param [Class<Ronin::Payloads::Payload>] payload
        #   The payload class that is including {Metadata::OS}.
        #
        # @api private
        #
        def self.included(payload)
          payload.extend ClassMethods
        end

        module ClassMethods
          #
          # Gets or sets the payload's targeted Operating System (OS).
          #
          # @param [Symbol, nil] new_os
          #   The optional new Operating System (OS) to set.
          #
          # @return [Symbol, nil]
          #   The payload's Operating System (OS).
          #
          # @example
          #   os :linux
          #
          # @api public
          #
          def os(new_os=nil)
            if new_os
              @os = new_os
            else
              @os ||= if superclass.kind_of?(ClassMethods)
                        superclass.os
                      end
            end
          end

          #
          # Gets or sets the payload's targeted Operating System (OS) version.
          #
          # @param [Symbol, nil] new_os_version
          #   The optional new Operating System (OS) version to set.
          #
          # @return [Symbol, nil]
          #   The payload's Operating System (OS) version.
          #
          # @example
          #   os :linux
          #   os_version '5.x'
          #
          # @api public
          #
          def os_version(new_os_version=nil)
            if new_os_version
              @os_version = new_os_version
            else
              @os_version ||= if superclass.kind_of?(ClassMethods)
                                superclass.os_version
                              end
            end
          end
        end

        #
        # The Operating System (OS) that the payload targets.
        #
        # @return [Symbol, nil]
        #
        # @see ClassMethods#os
        #
        def os
          self.class.os
        end

        #
        # The Operating System (OS) version that the payload targets.
        #
        # @return [String, nil]
        #
        # @see ClassMethods#os_version
        #
        def os_version
          self.class.os_version
        end
      end
    end
  end
end
