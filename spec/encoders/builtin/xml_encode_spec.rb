require 'spec_helper'
require 'ronin/payloads/encoders/builtin/xml_encode'

describe Ronin::Payloads::Encoders::XMLEncode do
  it "must inherit from Ronin::Payloads::Encoders::XMLEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::XMLEncoder
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "&#104;&#101;&#108;&#108;&#111;&#32;&#119;&#111;&#114;&#108;&#100;" }

    it "must XML encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
