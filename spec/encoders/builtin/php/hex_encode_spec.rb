require 'spec_helper'
require 'ronin/payloads/encoders/builtin/php/hex_encode'

describe Ronin::Payloads::Encoders::PHP::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::PHPEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PHPEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'php/hex_encode'" do
      expect(subject.id).to eq('php/hex_encode')
    end
  end

  describe "#encode" do
    let(:php)     { "echo 'PWNED';" }
    let(:encoded) { %{eval(hex2bin("6563686f202750574e4544273b"));} }

    it "must encode the given PHP code as a hex string and embed it into the 'eval(hex2bin(\"...\"));' string" do
      expect(subject.encode(php)).to eq(encoded)
    end

    it "must return valid PHP code", :integration do
      expect(`php -r '#{subject.encode(php)}'`).to eq("PWNED")
    end
  end
end
