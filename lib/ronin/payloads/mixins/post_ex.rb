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

module Ronin
  module Payloads
    module Mixins
      #
      # Adds post-exploitation functionality to a payload class.
      #
      module PostEx
        # The post-exploitation session.
        #
        # @return [Ronin::PostEx::Session, nil]
        attr_accessor :session

        #
        # Closes the {#session} if it has been set.
        #
        def perform_cleanup
          if @session
            @session.close
            @session = nil
          end

          super
        end
      end
    end
  end
end
