#
#--
# Ronin Exploits - A Ruby library for Ronin that provides exploitation and
# payload crafting functionality.
#
# Copyright (c) 2007-2009 Hal Brodigan (postmodern.mod3 at gmail.com)
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
#++
#

require 'ronin/payloads/payload'
require 'ronin/arch'
require 'ronin/os'

module Ronin
  module Payloads
    class BinaryPayload < Payload

      objectify :ronin_binary_payload

      # The payloads targeted architecture
      belongs_to :arch,
                 :child_key => [:arch_id]

      # The payloads targeted OS
      belongs_to :os,
                 :child_key => [:os_id],
                 :class_name => '::Ronin::OS'

    end
  end
end
