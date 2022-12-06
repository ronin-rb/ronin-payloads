require 'spec_helper'
require 'ronin/payloads/shellcode_payload'

describe Ronin::Payloads::ShellcodePayload do
  it "must inherit from Ronin::Payloads::ASMPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::ASMPayload)
  end

  describe "#shellcode" do
    it "must return the assembled program" do
      output = subject.shellcode(arch: :x86, os: :linux) do
        mov   al, syscalls[:exit]
        int   0xb
      end

      expect(output).to_not be_empty
    end
  end
end
