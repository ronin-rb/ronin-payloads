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

module Ronin
  module Payloads
    class CLI
      module Printing
        module Metadata
          # Mapping of architecture IDs to printable names.
          ARCH_NAMES = {
            x86: 'x86',

            x86_64: 'x86-64',
            ia64:   'IA64',
            amd64:  'x86-64',

            ppc:   'PPC',
            ppc64: 'PPC64',

            mips:    'MIPS',
            mips_le: 'MIPS (LE)',
            mips_be: 'MIPS',

            mips64:    'MIPS64',
            mips64_le: 'MIPS64 (LE)',
            mips64_be: 'MIPS64',

            arm:      'ARM',
            arm_le:   'ARM',
            arm_be:   'ARM (BE)',

            arm64:    'ARM64',
            arm64_le: 'ARM64',
            arm64_be: 'ARM64 (BE)'
          }

          #
          # Converts the architecture ID to a printable name.
          #
          # @param [Symbol] arch
          #
          # @return [String]
          #
          def arch_name(arch)
            ARCH_NAMES.fetch(arch,&:to_s)
          end

          # Mapping of Operating System (OS) IDs to printable names.
          OS_NAMES = {
            unix:  'UNIX',

            bsd:     'BSD',
            freebsd: 'FreeBSD',
            openbsd: 'OpenBSD',
            netbsd:  'NetBSD',

            linux:   'Linux',
            macos:   'macOS',
            windows: 'Windows'
          }

          #
          # Converts the Operating System (OS) ID to a printable name.
          #
          # @param [Symbol] os
          #
          # @return [String]
          #
          def os_name(os)
            OS_NAMES.fetch(os,&:to_s)
          end
        end
      end
    end
  end
end
