#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-payloads.
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

require 'ronin/ui/cli/resources_command'
require 'ronin/encoders/encoder'

module Ronin
  module UI
    module CLI
      module Commands
        class Exploits < ResourcesCommand

          summary 'Lists available encoders'

          model Ronin::Encoders::Encoder

          query_option :named, type:  String,
                               flag:  '-n',
                               usage: 'NAME'

          query_option :revision, type:  String,
                                  flag:  '-V',
                                  usage: 'VERSION'

          query_option :describing, type:  String,
                                    flag:  '-d',
                                    usage: 'TEXT'

          query_option :status, type:  String,
                                flag:  '-s',
                                usage: 'potential|proven|weaponized'

          query_option :licensed_under, type:  String,
                                        flag:  '-l',
                                        usage: 'LICENSE'

          option :verbose, type: true,
                           flag: '-v'

          protected

          def print_resource(encoder)
            unless verbose?
              puts "  #{encoder}"
              return
            end

            print_section "Encoder: #{encoder}" do
              puts "Name: #{encoder.name}"
              puts "Version: #{encoder.version}"
              puts "Type: #{encoder.type}"       if verbose?
              puts "License: #{encoder.license}" if encoder.license

              puts "Targets Arch: #{encoder.arch}" if encoder.arch
              puts "Targets OS: #{encoder.os}"     if encoder.os

              spacer

              if encoder.description
                puts "Description:"
                spacer

                indent do
                  encoder.description.each_line { |line| puts line }
                end

                spacer
              end

              unless encoder.authors.empty?
                print_section "Authors" do
                  encoder.authors.each { |author| puts author }
                end
              end

              begin
                encoder.load_script!
              rescue Exception => error
                print_exception error
              end

              unless encoder.params.empty?
                print_array encoder.params.values, title: 'Parameters'
              end
            end
          end

        end
      end
    end
  end
end
