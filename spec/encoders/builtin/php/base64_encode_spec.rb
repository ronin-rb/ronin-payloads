require 'spec_helper'
require 'ronin/payloads/encoders/builtin/php/base64_encode'

describe Ronin::Payloads::Encoders::PHP::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::PHPEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PHPEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'php/base64_encode'" do
      expect(subject.id).to eq('php/base64_encode')
    end
  end

  describe "#encode" do
    let(:php)     { "echo 'PWNED';" }
    let(:encoded) { %{eval(base64_decode("ZWNobyAnUFdORUQnOw=="));} }

    it "must encode the given PHP code as a Base64 string and embed it into the 'eval(base64_decode(\"...\"));' string" do
      expect(subject.encode(php)).to eq(encoded)
    end

    it "must return valid PHP code", :integration do
      expect(`php -r '#{subject.encode(php)}'`).to eq("PWNED")
    end
  end
end
