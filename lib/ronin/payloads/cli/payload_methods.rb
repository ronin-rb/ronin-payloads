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

require 'ronin/payloads/registry'

module Ronin
  module Payloads
    class CLI
      module PayloadMethods
        #
        # Loads a payload class.
        #
        # @param [String] name
        #   The payload name to load.
        #
        # @param [String, nil] fie
        #   The optional explicit file to load the payload from.
        #
        # @return [Class<Payload>]
        #   The loaded payload class.
        #
        def load_payload(name,file=nil)
          begin
            if file then Payloads.load_class_from_file(name,file)
            else         Payloads.load_class(name)
            end
          rescue Payloads::ClassNotFound => error
            print_error error.message
            exit(1)
          end
        end
      end
    end
  end
end
