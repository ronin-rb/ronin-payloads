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
require 'ronin/payloads/exceptions'
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
            if file
              Payloads.load_class_from_file(name,File.expand_path(file))
            else
              Payloads.load_class(name)
            end
          rescue Payloads::ClassNotFound => error
            print_error error.message
            exit(1)
          rescue => error
            print_exception(error)

            if file
              print_error "an unhandled exception occurred while loading payload #{name} from file #{file}"
            else
              print_error "an unhandled exception occurred while loading payload #{name}"
            end

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

        #
        # Validates the loaded payload.
        #
        # @param [Payload] payload
        #   The payload to validate.
        #
        # @raise [Ronin::Core::Params::RequiredParam]
        #   One of the required params was not set.
        #
        # @raise [ValidationError]
        #   Another payload validation error occurred.
        #
        def validate_payload(payload)
          begin
            payload.validate
          rescue Core::Params::ParamError, ValidationError => error
            print_error "failed to validate the payload #{payload.class_id}: #{error.message}"
            exit(1)
          rescue => error
            print_exception(error)
            print_error "an unhandled exception occurred while validating the payload #{payload.class_id}"
            exit(-1)
          end
        end

      end
    end
  end
end
