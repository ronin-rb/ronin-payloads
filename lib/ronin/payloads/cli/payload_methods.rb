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

require 'ronin/payloads/registry'
require 'ronin/core/params/exceptions'

module Ronin
  module Payloads
    class CLI
      module PayloadMethods
        #
        # Loads a payload class.
        #
        # @param [String] name
        #   The payload name to load.
        #
        # @param [String, nil] fie
        #   The optional explicit file to load the payload from.
        #
        # @return [Class<Payload>]
        #   The loaded payload class.
        #
        def load_payload(name,file=nil)
          begin
            if file then Payloads.load_class_from_file(name,file)
            else         Payloads.load_class(name)
            end
          rescue Payloads::ClassNotFound => error
            print_error error.message
            exit(1)
          rescue => error
            print_exception(error)
            print_error "an unhandled exception occurred while loading payload #{name}"
            exit(-1)
          end
        end

        #
        # Initializes the payload class.
        #
        # @param [Class<Payload>] payload_class
        #   The encoder class.
        #
        # @param [Hash{Symbol => Object}] kwargs
        #   Additional keyword arguments for {Payload#initialize}.
        #
        def initialize_payload(payload_class,**kwargs)
          begin
            payload_class.new(**kwargs)
          rescue Core::Params::ParamError => error
            print_error error.message
            exit(1)
          rescue => error
            print_exception(error)
            print_error "an unhandled exception occurred while initializing payload #{payload_class.id}"
            exit(-1)
          end
        end
      end
    end
  end
end
