#
# Ronin Exploits - A Ruby library for Ronin that provides exploitation and
# payload crafting functionality.
#
# Copyright (c) 2007-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/payloads/exceptions/not_implemented'

module Ronin
  module Payloads
    module Helpers
      module Rpc
        #
        # Calls a specific method with additional arguments.
        #
        # @param [Symbol, String] method
        #   The method name to call.
        #
        # @param [Array] arguments
        #   The arguments to use when calling the method.
        #
        # @return [Object]
        #   The result of the method call.
        #
        # @since 0.3.0
        #
        def call_method(method,*arguments)
          raise(NotImplemented,"the call method is unimplemented",caller)
        end

        #
        # Evaluates code.
        #
        # @param [String] code
        #   The code to evaluate.
        #
        # @return [Object]
        #   The result of the code evaluation.
        #
        # @since 0.3.0
        #
        def eval(code)
          call_method(:eval,code)
        end

        #
        # Exits the process.
        #
        # @param [Integer] status
        #   The status to exit with.
        #
        # @since 0.3.0
        #
        def exit(status=0)
          call_method(:exit,status)
        end

        protected

        #
        # Provides transparent access to remote methods using the
        # specified _name_ and given _arguments_.
        #
        # @since 0.3.0
        #
        def method_missing(name,*arguments,&block)
          name = name.to_s

          if (name[-1..-1] != '=' && block.nil?)
            return call_method(name,*arguments)
          end

          return super(name,*arguments,&block)
        end
      end
    end
  end
end
