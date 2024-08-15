require 'spec_helper'
require 'ronin/payloads/encoders/builtin/js/hex_encode'

describe Ronin::Payloads::Encoders::JS::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::JavaScriptEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::JavaScriptEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'js/hex_encode'" do
      expect(subject.id).to eq('js/hex_encode')
    end
  end

  describe "#encode" do
    let(:command) { "alert(1)" }
    let(:encoded) { %{eval("\\x61\\x6C\\x65\\x72\\x74\\x28\\x31\\x29")} }

    it "must encode each character of the given String as a hex escaped character and evaluate the resulting String using 'eval()'" do
      expect(subject.encode(command)).to eq(encoded)
    end
  end
end
