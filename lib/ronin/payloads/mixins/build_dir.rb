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

require 'tmpdir'
require 'fileutils'

module Ronin
  module Payloads
    module Mixins
      #
      # Sets up a temporary build directory for the payload.
      #
      # @api public
      #
      module BuildDir
        # The build directory for the payload.
        #
        # @return [String, nil]
        attr_reader :build_dir

        #
        # Sets {#build_dir} and then builds the payload.
        #
        def perform_build
          payload_name = self.class.id.tr('/','-')
          @build_dir   = Dir.mktmpdir("ronin-payloads-#{payload_name}-")

          super
        end

        #
        # Cleans up the payload and deletes the {#build_dir}.
        #
        def perform_cleanup
          super

          FileUtils.rm_r(@build_dir)
          @build_dir = nil
        end
      end
    end
  end
end
