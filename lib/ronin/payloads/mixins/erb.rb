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

require 'ronin/support/text/erb/mixin'

module Ronin
  module Payloads
    module Mixins
      #
      # Adds support for rendering [ERB] templates.
      #
      # [ERB]: https://docs.ruby-lang.org/en/3.1/ERB.html
      #
      # @see https://ronin-rb.dev/docs/ronin-support/Ronin/Support/Text/ERB/Mixin.html
      #
      # @api public
      #
      module ERB
        include Support::Text::ERB::Mixin
      end
    end
  end
end
