require 'spec_helper'
require 'ronin/payloads/encoders/builtin/ruby/base64_encode'

describe Ronin::Payloads::Encoders::Ruby::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::RubyEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::RubyEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'ruby/base64_encode'" do
      expect(subject.id).to eq('ruby/base64_encode')
    end
  end

  describe "#encode" do
    let(:ruby)    { "puts('PWNED')" }
    let(:encoded) { %{eval("cHV0cygnUFdORUQnKQ==".unpack("m0").first)} }

    it "must encode the given Ruby code as a Base64 string and embed it into the 'eval(\"...\".unpack1(\"m0\")' string" do
      expect(subject.encode(ruby)).to eq(encoded)
    end

    it "must return valid Ruby code", :integration do
      expect(`ruby -e '#{subject.encode(ruby)}'`).to eq("PWNED#{$/}")
    end
  end
end
