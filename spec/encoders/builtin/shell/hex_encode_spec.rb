require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/hex_encode'

describe Ronin::Payloads::Encoders::Shell::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::ShellCommandEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellCommandEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shell/hex_encode'" do
      expect(subject.id).to eq('shell/hex_encode')
    end
  end

  describe "#encode" do
    let(:command) { "echo PWNED" }
    let(:encoded) { "echo 6563686f2050574e4544|xxd -r -p|bash" }

    it "must encode the given command String into a hex string and embed it into the `xxd -r -ps|bash` command" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the shell param is set" do
      let(:shell)   { 'zsh' }
      let(:encoded) { "echo 6563686f2050574e4544|xxd -r -p|#{shell}" }

      subject do
        described_class.new(params: {shell: shell})
      end

      it "must use the shell param in the command" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end

    it "must return a valid shell command", :integration do
      expect(`#{subject.encode(command)}`).to eq("PWNED#{$/}")
    end
  end
end
