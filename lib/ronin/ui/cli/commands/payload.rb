#
# Ronin Exploits - A Ruby library for Ronin that provides exploitation and
# payload crafting functionality.
#
# Copyright (c) 2007-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/ui/cli/script_command'
require 'ronin/payloads/payload'
require 'ronin/ui/console'

module Ronin
  module UI
    module CLI
      module Commands
        class Payload < ScriptCommand

          desc 'Builds the specified Payload'

          script_class Ronin::Payloads::Payload

          query_option :targeting_arch, :type => :string, :aliases => '-a'
          query_option :targeting_os, :type => :string, :aliases => '-o'

          class_option :host, :type => :string
          class_option :port, :type => :numeric
          class_option :local_host, :type => :string
          class_option :local_port, :type => :numeric

          class_option :dump, :type => :boolean, :default => true
          class_option :raw, :type => :boolean, :aliases => '-r'
          class_option :deploy, :type => :boolean,
                                :default => false,
                                :aliases => '-D'
          class_option :shell_console, :type => :boolean, :default => false
          class_option :fs_console, :type => :boolean, :default => false

          argument :name, :type => :string, :required => false

          def execute
            # silence all output, if we are to print the built payload
            UI::Output.silent! if options.raw?

            @payload = load_script

            params = options[:params]
            params[:host] = options[:host] if options[:host]
            params[:port] = options[:port] if options[:port]
            params[:local_host] = options[:local_host] if options[:local_host]
            params[:local_port] = options[:local_port] if options[:local_port]

            begin
              # Build the payload
              @payload.build!(params)
            rescue Script::Exception,
                   Payloads::Exception => error
              print_error error.message
              exit -1
            end

            if options.dump?
              dump_payload!
            elsif options.deploy?
              deploy_payload!
            end
          end

          protected

          def dump_payload!
            raw_payload = @payload.raw_payload

            unless options.console?
              if options.raw?
                # Write the raw payload
                STDOUT.write(raw_payload)
              else
                # Dump the built payload
                puts raw_payload.dump
              end
            else
              print_info 'Starting the console with @payload set ...'
              print_info '  @payload.raw_payload  # for the raw payload.'
              print_info '  @payload.build!       # rebuilds the payload.'

              UI::Console.start(:payload => payload)
            end
          end

          def deploy_payload!
            begin
              @payload.deploy!
            rescue Script::TestFailed, Payloads::Exception => e
              print_error(e.message)
              exit -1
            end

            if options.shell_console?
              if @payload.leverages?(:shell)
                @payload.shell.console
              else
                print_error "The payload does not leverage the shell"
              end
            elsif options.fs_console?
              if @payload.leverages?(:fs)
                @payload.fs.console
              else
                print_error "The payload does not leverage the file system"
              end
            elsif options.console?
              print_info 'Starting the console with @payload set ...'

              UI::Console.start(:payload => @payload)
            end

            @payload.evacuate!
          end

        end
      end
    end
  end
end
