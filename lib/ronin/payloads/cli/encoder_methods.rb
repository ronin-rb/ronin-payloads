# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../encoders/registry'
require_relative '../encoders/exceptions'

require 'ronin/core/params/exceptions'

module Ronin
  module Payloads
    class CLI
      #
      # Common methods for handling encoders.
      #
      module EncoderMethods
        # Known payload encoder types and their printable names.
        ENCODER_TYPES = {
          encoder:         'Custom',
          command:         'Command',
          shell_command:   'Shell Command',
          windows_command: 'Windows Command',
          html:            'HTML',
          javascript:      'JavaScript',
          node_js:         'Node.js',
          perl:            'Perl',
          powershell:      'PowerShell',
          sql:             'SQL',
          xml:             'XML'
        }

        #
        # Returns the encoder type for the encoder class.
        #
        # @param [Class<Encoders::Encoder>] encoder_class
        #   The encoder class.
        #
        # @return [String]
        #
        def encoder_type(encoder_class)
          ENCODER_TYPES.fetch(encoder_class.encoder_type,'Unknown')
        end

        #
        # Loads a encoder class.
        #
        # @param [String] name
        #   The encoder name to load.
        #
        # @return [Class<Encoders::Encoder>]
        #   The loaded encoder class.
        #
        def load_encoder(name)
          Payloads::Encoders.load_class(name)
        rescue Payloads::Encoders::ClassNotFound => error
          print_error(error.message)
          exit(1)
        rescue => error
          print_exception(error)
          print_error("an unhandled exception occurred while loading encoder #{name}")
          exit(-1)
        end

        #
        # Loads the encoder from a given file.
        #
        # @param [String] file
        #   The file to load the encoder class from.
        #
        # @return [Class<Encoders::Encoder>]
        #   The loaded encoder class.
        #
        def load_encoder_from(file)
          Payloads::Encoders.load_class_from_file(file)
        rescue Payloads::Encoders::ClassNotFound => error
          print_error(error.message)
          exit(1)
        rescue => error
          print_exception(error)
          print_error("an unhandled exception occurred while loading encoder from file #{file}")
          exit(-1)
        end

        #
        # Initializes an encoder.
        #
        # @param [Class<Encoders::Encoder>] encoder_class
        #   The encoder class.
        #
        # @param [Hash{Symbol => Object}] kwargs
        #   Additional keyword arguments for {Ronin::Payloads::Encoders::Encoder#initialize}.
        #
        # @return [Encoders::Encoder]
        #   The initialized encoder object.
        #
        def initialize_encoder(encoder_class,**kwargs)
          encoder_class.new(**kwargs)
        rescue Core::Params::ParamError => error
          print_error(error.message)
          exit(1)
        rescue => error
          print_exception(error)
          print_error("an unhandled exception occurred while initializing encoder #{encoder_class.id}")
          exit(-1)
        end

        #
        # Validates the loaded encoder.
        #
        # @param [Encoders::Encoder] encoder
        #   The encoder to validate.
        #
        # @raise [Ronin::Core::Params::RequiredParam]
        #   One of the required params was not set.
        #
        # @raise [ValidationError]
        #   Another encoder validation error occurred.
        #
        def validate_encoder(encoder)
          encoder.validate
        rescue Core::Params::ParamError, Encoders::ValidationError => error
          print_error("failed to validate the encoder #{encoder.class_id}: #{error.message}")
          exit(1)
        rescue => error
          print_exception(error)
          print_error("an unhandled exception occurred while validating the encoder #{encoder.class_id}")
          exit(-1)
        end
      end
    end
  end
end
