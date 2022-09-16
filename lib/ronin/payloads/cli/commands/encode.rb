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
        # ## Options
        #
        # ## Arguments
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
                           desc: 'The encoder name to load' do |name|
                             @encoders << name
                           end

          option :param, short: '-p',
                         value: {
                           type: /\A[^\.=]+\.[^=]++=.+\z/,
                           usage: 'ENCODER.NAME=VALUE'
                         },
                         desc: 'Sets a param on an encoder' do |str|
                           name, value              = str.split('=',2)
                           ecndoer_name, param_name = name.split('.',2)

                           @params[encoder_name][param_name] = value
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

            @encoders.each do |encoder_name|
              encoder_class = load_encoder(encoder_name)
              encoder = encoder_class.new(params: @params[encoder_name])

              @pipeline << encoder
            end
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
              print_error "must specify either FILE or --string"
              exit(-1)
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
            begin
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
end
