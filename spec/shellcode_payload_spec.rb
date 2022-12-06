require 'spec_helper'
require 'ronin/payloads/shellcode_payload'

describe Ronin::Payloads::ShellcodePayload do
  module TestShellcodePayload
    class TestPayload < Ronin::Payloads::ShellcodePayload
      arch :x86
      os :linux
    end
  end

  it "must inherit from Ronin::Payloads::ASMPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::ASMPayload)
  end

  let(:payload_class) { TestShellcodePayload::TestPayload }
  subject { payload_class.new }

  describe "#shellcode" do
    it "must return the assembled program" do
      output = subject.shellcode do
        mov   al, syscalls[:exit]
        int   0xb
      end

      expect(output).to_not be_empty
    end

    it "must set #payload" do
      output = subject.shellcode do
        mov   al, syscalls[:exit]
        int   0xb
      end

      expect(subject.payload).to be(output)
    end
  end
end
