require 'spec_helper'
require 'ronin/payloads/encoders/builtin/ruby/hex_encode'

describe Ronin::Payloads::Encoders::Ruby::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::RubyEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::RubyEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'ruby/hex_encode'" do
      expect(subject.id).to eq('ruby/hex_encode')
    end
  end

  describe "#encode" do
    let(:ruby)    { %{puts "PWNED"} }
    let(:encoded) { %{eval("70757473202250574e454422".scan(/../).map(&:hex).map(&:chr).join)} }

    it "must encode the given Ruby code as a hex string and embed it into the 'eval(\"...\".scan(/../).map(&:hex).map(&:chr).join)' string" do
      expect(subject.encode(ruby)).to eq(encoded)
    end

    it "must return valid Ruby code", :integration do
      expect(`ruby -e '#{subject.encode(ruby)}'`).to eq("PWNED#{$/}")
    end
  end
end
