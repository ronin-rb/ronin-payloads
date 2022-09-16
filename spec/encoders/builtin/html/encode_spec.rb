require 'spec_helper'
require 'ronin/payloads/encoders/builtin/html/encode'

describe Ronin::Payloads::Encoders::HTML::Encode do
  it "must inherit from Ronin::Payloads::Encoders::HTMLEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::HTMLEncoder
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "&#104;&#101;&#108;&#108;&#111;&#32;&#119;&#111;&#114;&#108;&#100;" }

    it "must HTML encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
