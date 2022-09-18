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

require 'ronin/payloads/javascript_payload'

module Ronin
  module Payloads
    #
    # A {Payload} class that represents all TypeScript payloads.
    #
    class TypeScriptPayload < JavaScriptPayload

      #
      # The default `tsc` compiler.
      #
      # @return [String]
      #
      def self.tsc
        ENV['TSC'] || 'tsc'
      end

      param :tsc, required: true,
                  default:  ->{ tsc },
                  desc:     'The TypeScript compiler to use'

      #
      # Compiles one or more source files.
      #
      # @param [Array<String>] source_files
      #   The source files to compile.
      #
      # @return [Boolean, nil]
      #   Indicates whether the `tsc` command succeeded or failed.
      #
      def compile(*source_files)
        system(params[:tsc],*source_files)
      end

    end
  end
end
