require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/hex_escape'

describe Ronin::Payloads::Encoders::Shell::HexEscape do
  it "must inherit from Ronin::Payloads::Encoders::ShellCommandEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellCommandEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shell/hex_escape'" do
      expect(subject.id).to eq('shell/hex_escape')
    end
  end

  describe "#encode" do
    let(:command) { "echo PWNED" }
    let(:encoded) { "$'\\x65\\x63\\x68\\x6f' $'\\x50\\x57\\x4e\\x45\\x44'" }

    it "must encode each argument in the given command string into a hex strings" do
      expect(subject.encode(command)).to eq(encoded)
    end

    it "must return a valid shell command", :integration do
      expect(`bash -c "#{subject.encode(command)}"`).to eq("PWNED#{$/}")
    end
  end
end
