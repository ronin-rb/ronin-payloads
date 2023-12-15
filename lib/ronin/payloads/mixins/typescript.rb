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

require 'ronin/payloads/javascript_payload'

module Ronin
  module Payloads
    module Mixins
      #
      # A mixin for compiling TypeScript into JavaScript.
      #
      module TypeScript
        #
        # The default `tsc` compiler.
        #
        # @return [String]
        #
        def self.tsc
          ENV['TSC'] || 'tsc'
        end

        #
        # Adds the `tsc` param to the payload class.
        #
        # @param [Class<Payload>] payload_class
        #   The payload class including {TypeScript}.
        #
        def self.included(payload_class)
          payload_class.param :tsc, required: true,
                                    default:  -> { tsc },
                                    desc:     'The TypeScript compiler to use'
        end

        #
        # Compiles one or more source files.
        #
        # @param [Array<String>] source_files
        #   The source files to compile.
        #
        # @raise [BuildFailed]
        #   The `tsc` command failed or is not installed.
        #
        # @since 0.2.0
        #
        def compile_ts(*source_files)
          args = [params[:tsc]]
          args.concat(source_files)

          case system(*args)
          when false
            raise(BuildFailed,"tsc command failed: #{args.join(' ')}")
          when nil
            raise(BuildFailed,"tsc command not installed")
          end
        end

        alias compile compile_ts
      end
    end
  end
end
