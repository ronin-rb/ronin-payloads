require 'spec_helper'
require 'ronin/payloads/encoders/builtin/ruby/base64_encode'

describe Ronin::Payloads::Encoders::Ruby::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::RubyEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::RubyEncoder
  end

  describe "#encode" do
    let(:ruby)    { "puts('PWNED')" }
    let(:encoded) { %{require 'base64'; eval(Base64.decode64("cHV0cygnUFdORUQnKQ=="))} }

    it "must encode the given Ruby code as a Base64 string and embed it into the 'require 'base64'; eval(Base64.decode64(\"...\"))' string" do
      expect(subject.encode(ruby)).to eq(encoded)
    end
  end
end
