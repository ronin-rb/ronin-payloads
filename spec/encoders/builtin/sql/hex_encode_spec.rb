require 'spec_helper'
require 'ronin/payloads/encoders/builtin/sql/hex_encode'

describe Ronin::Payloads::Encoders::SQL::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::SQLEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::SQLEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'sql/hex_encode'" do
      expect(subject.id).to eq('sql/hex_encode')
    end
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "0x68656c6c6f20776f726c64" }

    it "must SQL encode the given String" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
