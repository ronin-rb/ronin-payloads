require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/hex_escape'

describe Ronin::Payloads::Encoders::Shell::HexEscape do
  it "must inherit from Ronin::Payloads::Encoders::ShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellEncoder
  end

  describe "#encode" do
    let(:command) { "ls -la" }
    let(:encoded) { "$'\\x6c\\x73' $'\\x2d\\x6c\\x61'" }

    it "must encode each argument in the given command string into a hex strings" do
      expect(subject.encode(command)).to eq(encoded)
    end
  end
end
