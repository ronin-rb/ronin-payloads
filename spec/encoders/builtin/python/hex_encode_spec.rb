require 'spec_helper'
require 'ronin/payloads/encoders/builtin/python/hex_encode'

describe Ronin::Payloads::Encoders::Python::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::PythonEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PythonEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'python/hex_encode'" do
      expect(subject.id).to eq('python/hex_encode')
    end
  end

  describe "#encode" do
    let(:python)  { "print('PWNED')" }
    let(:encoded) { %{import binascii; exec(binascii.unhexlify("7072696e74282750574e45442729"))} }

    it "must encode the given Python code as a hex string and embed it into the 'import binascii; exec(binascii.unhexlify(\"...\"))' string" do
      expect(subject.encode(python)).to eq(encoded)
    end
  end
end
