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

require_relative '../payload_command'
require_relative '../format_option'
require_relative '../encoder_methods'
require_relative '../text'

require 'ronin/core/cli/options/param'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Loads and builds a payload.
        #
        # ## Usage
        #
        #     ronin-payloads build [options] {-f FILE | NAME}
        #
        # ## Options
        #
        #     -f, --file FILE                  The payload file to load
        #     -F hex|c|shell|powershell|xml|html|js|ruby,
        #         --format                     Formats the outputed data
        #     -p, --param NAME=VALUE           Sets a param
        #     -o, --output FILE                Output file to write the built payload to
        #     -E, --encoder ENCODER            Adds the encoder to the payload
        #         --encoder-param ENCODER.NAME=VALUE
        #                                      Sets a param for one of the encoders
        #     -C perl|php|python|ruby|nodejs|html|command,
        #         --convert-to                 Optionally converts the payload into another payload type
        #     -D, --debug                      Enables debugging messages
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [NAME]                           The payload name to load
        #
        class Build < PayloadCommand

          include FormatOption
          include EncoderMethods
          include Core::CLI::Options::Param
          include Text

          option :output, short: '-o',
                          value: {
                            type:  String,
                            usage: 'FILE'
                          },
                          desc: 'Output file to write the built payload to'

          option :encoder, short: '-E',
                           value: {
                             type:  String,
                             usage: 'ENCODER'
                           },
                           desc: 'Adds the encoder to the payload' do |name|
                             @encoder_ids << name
                           end

          option :encoder_param, value: {
                                   type: /\A[^\.=]+\.[^=]++=.+\z/,
                                   usage: 'ENCODER.NAME=VALUE'
                                 },
                                 desc: 'Sets a param for one of the encoders' do |str|
                                   name, value              = str.split('=',2)
                                   encoder_name, param_name = name.split('.',2)

                                   @encoder_params[encoder_name][param_name.to_sym] = value
                                 end

          option :convert_to, short: '-C',
                              value: {
                                type: {
                                  'perl'    => :perl,
                                  'php'     => :php,
                                  'python'  => :python,
                                  'ruby'    => :ruby,
                                  'nodejs'  => :node_js,
                                  'html'    => :html,
                                  'command' => :command
                                }
                              },
                              desc: 'Optionally converts the payload into another payload type'

          option :debug, short: '-D',
                         desc: 'Enables debugging messages' do
                           Support::CLI::Printing.debug = true
                         end

          description 'Loads and builds a payload'

          man_page 'ronin-payloads-build.1'

          # The encoder names to load.
          #
          # @return [Array<String>]
          attr_reader :encoder_ids

          # The params for the encoders.
          #
          # @return [Hash{String => Hash{String => String}}]
          attr_reader :encoder_params

          #
          # Initializes the `ronin-payloads build` command.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments.
          #
          def initialize(**kwargs)
            super(**kwargs)

            @encoder_ids    = []
            @encoder_params = Hash.new { |hash,key| hash[key] = {} }
          end

          #
          # Runs the `ronin-payloads build` command.
          #
          # @param [String, nil] name
          #   The name of the payload to load.
          #
          def run(name=nil)
            super(name)

            load_encoders
            initialize_payload
            validate_payload
            build_payload
            convert_payload if options[:convert_to]

            if options[:output] then write_payload
            else                     print_payload
            end
          end

          #
          # Loads the encoders using {#encoder_ids} which are populated by
          # the `-E,--encoder` option.
          #
          def load_encoders
            @encoders = @encoder_ids.map do |encoder_id|
              encoder_class = load_encoder(encoder_id)
              params        = @encoder_params[encoder_id]
              encoder       = initialize_encoder(encoder_class, params: params)

              validate_encoder(encoder)
              encoder
            end
          end

          #
          # Initializes the payload with `--param` and `--encoder` options.
          #
          def initialize_payload
            super(params: @params, encoders: @encoders)
          end

          #
          # Builds the {#payload}.
          #
          def build_payload
            @payload.perform_build
          rescue PayloadError => error
            print_error "failed to build the payload #{@payload_class.id}: #{error.message}"
            exit(-1)
          rescue => error
            print_exception(error)
            print_error "an unhandled exception occurred while building the payload #{@payload.class_id}"
            exit(-1)
          end

          #
          # Optionally converts the payload into a different payload type.
          #
          # @since 0.3.0
          #
          def convert_payload
            convert_to = options[:convert_to]
            to_method  = "to_#{convert_to}"

            unless @payload.respond_to?(to_method)
              from_payload_type = payload_type_name(@payload_class)
              to_payload_type   = PAYLOAD_TYPE_NAMES.fetch(convert_to)

              print_error "unable to convert payload #{@payload_class.id} of type #{from_payload_type} into a #{to_payload_type}"
              exit(-1)
            end

            @payload = @payload.public_send(to_method)
          end

          #
          # Writes the built and optionally encoded payload to the output file.
          #
          def write_payload
            File.binwrite(options[:output],format_data(@payload.to_s))
          end

          #
          # Prints the built and optionally encoded payload.
          #
          def print_payload
            print_data(@payload.to_s)
          end

        end
      end
    end
  end
end
