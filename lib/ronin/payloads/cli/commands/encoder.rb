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

require_relative '../command'
require_relative '../encoder_methods'
require_relative '../../metadata/arch'
require_relative '../../metadata/os'

require 'ronin/core/cli/printing/metadata'
require 'ronin/core/cli/printing/arch'
require 'ronin/core/cli/printing/os'
require 'ronin/core/cli/printing/params'

require 'command_kit/printing/fields'

module Ronin
  module Payloads
    class CLI
      module Commands
        #
        # Prints information about an encoder.
        #
        class Encoder < Command

          include Core::CLI::Printing::Metadata
          include Core::CLI::Printing::Arch
          include Core::CLI::Printing::OS
          include Core::CLI::Printing::Params
          include EncoderMethods
          include CommandKit::Printing::Fields

          usage '[options] [NAME]'

          option :file, short: '-f',
                        value: {
                          type:  String,
                          usage: 'FILE'
                        },
                        desc: 'The optional file to load the encoder from'

          argument :name, required: false,
                          desc:     'The optional encoder name to list'

          description 'Prints information about an encoder'

          man_page 'ronin-payloads-encoder.1'

          #
          # Runs the `ronin-payloads encoder` command.
          #
          # @param [String, nil] name
          #   The optional name of the encoder to load and print metadata about.
          #
          def run(name=nil)
            encoder_class = if name
                              load_encoder(name)
                            elsif options[:file]
                              load_encoder_from(options[:file])
                            else
                              print_error "must specify --file or a NAME"
                              exit(-1)
                            end

            print_encoder(encoder_class)
          end

          #
          # Prints metadata for an encoder class.
          #
          # @param [Class<Payloads::Encoders::Encoder>] encoder_class
          #   The encoder class to print.
          #
          def print_encoder(encoder_class)
            puts "[ #{encoder_class.id} ]"
            puts

            indent do
              fields = {}

              if (type = encoder_type(encoder_class))
                fields['Type'] = type
              end

              if encoder_class.include?(Metadata::Arch)
                if (arch = encoder_class.arch)
                  fields['Arch'] = arch_name(arch)
                end
              end

              if encoder_class.include?(Metadata::OS)
                if (os = encoder_class.os)
                  fields['OS'] = os_name(os)
                end
              end

              if (summary = encoder_class.summary)
                fields['Summary'] = summary
              end

              print_fields fields
              print_authors(encoder_class)
              print_description(encoder_class)
              print_references(encoder_class)
              print_params(encoder_class)
            end
          end

        end
      end
    end
  end
end
