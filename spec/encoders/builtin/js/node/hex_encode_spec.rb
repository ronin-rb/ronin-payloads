require 'spec_helper'
require 'ronin/payloads/encoders/builtin/js/node/hex_encode'

describe Ronin::Payloads::Encoders::JS::Node::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::NodeJSEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::NodeJSEncoder
  end

  describe "#encode" do
    let(:javascript)  { "console.log('PWNED')" }
    let(:encoded)     { %{eval(Buffer.from("636f6e736f6c652e6c6f67282750574e45442729","hex").toString("utf8"))} }

    it "must encode the given JavaScript code as a hex string and embed it into the 'eval(Buffer.from(\"...\",\"hex\").toString(\"utf8\"))' string" do
      expect(subject.encode(javascript)).to eq(encoded)
    end
  end
end
