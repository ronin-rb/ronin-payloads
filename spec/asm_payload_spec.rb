require 'spec_helper'
require 'ronin/payloads/asm_payload'

describe Ronin::Payloads::ASMPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  describe "#assemble" do
    it "must return the assembled program" do
      output = subject.assemble(arch: :x86, os: :linux) do
        mov   al, syscalls[:exit]
        int   0xb
      end

      expect(output).to_not be_empty
    end
  end
end
