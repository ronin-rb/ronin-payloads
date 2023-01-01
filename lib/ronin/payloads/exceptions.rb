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
    #
    # Exception base class for all `ronin-payload` exceptions.
    #
    class PayloadError < RuntimeError
    end

    #
    # Indicates that an incompatible encoder was added to the payload.
    #
    class IncompatibleEncoder < PayloadError
    end

    #
    # Indicates a validation error was encountered while validating the payload.
    #
    class ValidationError < PayloadError
    end

    #
    # Indicates the payload failed to build for some reason.
    #
    class BuildFailed < PayloadError
    end

    #
    # Indicates the payload was not actually built.
    #
    class PayloadNotBuilt < PayloadError
    end
  end
end
