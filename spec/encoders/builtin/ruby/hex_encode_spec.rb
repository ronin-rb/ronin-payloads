require 'spec_helper'
require 'ronin/payloads/encoders/builtin/ruby/hex_encode'

describe Ronin::Payloads::Encoders::Ruby::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::RubyEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::RubyEncoder
  end

  describe "#encode" do
    let(:ruby)    { "puts('PWNED')" }
    let(:encoded) { %{eval("70757473282750574e45442729".scan(/../).map(&:hex).map(&:chr).join)} }

    it "must encode the given Ruby code as a hex string and embed it into the 'eval(\"...\".scan(/../).map(&:hex).map(&:chr).join)' string" do
      expect(subject.encode(ruby)).to eq(encoded)
    end
  end
end
