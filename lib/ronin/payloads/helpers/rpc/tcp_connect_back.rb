#
# Ronin Exploits - A Ruby library for Ronin that provides exploitation and
# payload crafting functionality.
#
# Copyright (c) 2007-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin Exploits.
#
# Ronin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ronin.  If not, see <http://www.gnu.org/licenses/>
#

require 'ronin/network/tcp'

module Ronin
  module Payloads
    module Helpers
      module RPC
        #
        # RPC Transport methods for interacting with a TCP Service that
        # connects back.
        #
        module TCPConnectBack
          def self.extended(object)
            object.extend Network::TCP
          end

          protected

          def rpc_connect
            @server     = tcp_server(self.local_port,self.local_host)
            @connection = @server.accept
          end

          def rpc_disconnect
            if @connection
              @connection.close
              @connection = nil
            end

            @server.close
            @server = nil
          end

          def rpc_send(message)
            @connection.write(rpc_serialize(message) + "\0")

            return rpc_deserialize(@connection.readline("\0").chomp("\0"))
          end
        end
      end
    end
  end
end
