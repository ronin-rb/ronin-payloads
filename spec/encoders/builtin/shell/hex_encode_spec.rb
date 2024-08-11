require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/hex_encode'

describe Ronin::Payloads::Encoders::Shell::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::ShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellEncoder
  end

  describe "#encode" do
    let(:command) { "ls -la" }
    let(:encoded) { "echo 6c73202d6c61|xxd -r -p|bash" }

    it "must encode the given command String into a hex string and embed it into the `xxd -r -ps|bash` command" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the shell param is set" do
      let(:shell)   { 'zsh' }
      let(:encoded) { "echo 6c73202d6c61|xxd -r -p|#{shell}" }

      subject do
        described_class.new(params: {shell: shell})
      end

      it "must use the shell param in the command" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end
  end
end
