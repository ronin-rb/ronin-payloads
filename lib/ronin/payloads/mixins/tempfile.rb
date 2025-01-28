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

require 'tempfile'

module Ronin
  module Payloads
    module Mixins
      #
      # Adds support for temporary files.
      #
      # @api public
      #
      module Tempfile
        #
        # Opens a new temporary file.
        #
        # @param [String, nil] name
        #   The optional name for the temporary file.
        #
        # @param [String, ext] ext
        #   The optional file extension to add to the temporary file.
        #
        # @yield [tempfile]
        #   If a block is given it will be passed the newly opened temporary
        #   file. Once the block returns the temp file will be closed.
        #
        # @yieldparam [Tempfile] tempfile
        #   The newly created temporary file.
        #
        # @return [Tempfile]
        #   The newly created temporary file.
        #
        # @see https://rubydoc.info/stdlib/tempfile/Tempfile
        #
        def tempfile(name=nil, ext: nil,&block)
          basename = if name then "ronin-payloads-#{name}-"
                     else         'ronin-payloads-'
                     end

          ::Tempfile.open([basename, ext],&block)
        end
      end
    end
  end
end
