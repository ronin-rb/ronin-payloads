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

require 'ronin/payloads/cli/command'
require 'ronin/payloads/cli/format_option'
require 'ronin/payloads/cli/encoder_methods'
require 'ronin/payloads/encoders/pipeline'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Encodes data using the encoder(s).
        #
        # ## Usage
        #
        #     ronin-payloads encode [options] {--string STRING | FILE}
        #
        # ## Options
        #
        #     -F hex|c|shell|powershell|xml|html|js|ruby,
        #         --format                     Formats the outputed data
        #     -E, --encoder ENCODER            The encoder name to load
        #     -p, --param ENCODER.NAME=VALUE   Sets a param on an encoder
        #     -s, --string STRING              The string to encode
        #     -h, --help                       Print help information
        #
        # ## Arguments
        #
        #     [FILE]                           The optional file to read and encode
        #
        class Encode < Command

          include FormatOption
          include EncoderMethods

          usage '[options] {--string STRING | FILE}'

          option :encoder, short: '-E',
                           value: {
                             type:  String,
                             usage: 'ENCODER'
                           },
                           desc: 'The encoder name to load' do |id|
                             @encoders << id
                           end

          option :param, short: '-p',
                         value: {
                           type: /\A[^\.=]+\.[^=]++=.+\z/,
                           usage: 'ENCODER.NAME=VALUE'
                         },
                         desc: 'Sets a param on an encoder' do |str|
                           prefix, value = str.split('=',2)
                           encoder, name = prefix.split('.',2)

                           @params[encoder][name.to_sym] = value
                         end

          option :string, short: '-s',
                          value: {
                            type:  String,
                            usage: 'STRING',
                          },
                          desc: 'The string to encode'

          argument :file, required: false,
                          desc:     'The optional file to read and encode'

          description 'Encodes data using the encoder(s)'

          man_page 'ronin-payloads-encode.1'

          # The encoder names to load.
          #
          # @return [Array<String>]
          attr_reader :encoders

          # The params for the encoders.
          #
          # @return [Hash{String => Hash{String => String}}]
          attr_reader :params

          # The encoder pipeline.
          #
          # @return [Encoders::Pipeline, nil]
          attr_reader :pipeline

          #
          # Initializes the `ronin-payloads encode` command.
          #
          # @param [Hash{Symbol => Object}] kwargs
          #   Additional keyword arguments.
          #
          def initialize(**kwargs)
            super(**kwargs)

            @encoders = []
            @params   = Hash.new { |hash,key| hash[key] = {} }
          end

          #
          # Runs the `ronin-payloads encode` command.
          #
          # @param [String, nil] file
          #   The optional file to read data from and encode.
          #
          def run(file=nil)
            build_pipeline

            print_data(encode_data(load_data(file)))
          end

          #
          # Builds the encoder pipeline.
          #
          def build_pipeline
            @pipeline = Encoders::Pipeline.new

            @encoders.each do |encoder_id|
              encoder_class = load_encoder(encoder_id)
              params        = @params[encoder_id]
              encoder       = initialize_encoder(encoder_class, params: params)

              validate_encoder(encoder)

              @pipeline << encoder
            end
          end

          #
          # Validates the loaded encoders.
          #
          # @raise [Ronin::Core::Params::RequiredParam]
          #   One of the required params was not set.
          #
          # @raise [ValidationError]
          #   Another encoder validation error occurred.
          #
          def validate_encoder(encoder)
            encoder.validate
          rescue Core::Params::ParamError, ValidationError => error
            print_error "failed to validate the encoder #{encoder.class_id}: #{error.message}"
            exit(1)
          rescue => error
            print_error "an unhandled exception occurred while validating the encoder #{encoder.class_id}"
            print_exception(error)
            exit(-1)
          end

          #
          # Loads the data to encode.
          #
          # @return [String]
          #
          def load_data(file=nil)
            if file
              unless File.file?(file)
                print_error "No such file or directory: #{file}"
                exit(-1)
              end

              File.binread(file)
            elsif options[:string]
              options[:string]
            else
              stdin.read
            end
          end

          #
          # Encodes the data.
          #
          # @param [String] data
          #
          # @return [String]
          #
          def encode_data(data)
            @pipeline.encode(data)
          rescue => error
            print_error "unhandled exception occurred while encoding data"
            print_exception(error)
            exit(1)
          end

        end
      end
    end
  end
end
