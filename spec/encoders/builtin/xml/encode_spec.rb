require 'spec_helper'
require 'ronin/payloads/encoders/builtin/xml/encode'

require 'nokogiri'

describe Ronin::Payloads::Encoders::XML::Encode do
  it "must inherit from Ronin::Payloads::Encoders::XMLEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::XMLEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'xml/encode'" do
      expect(subject.id).to eq('xml/encode')
    end
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "&#104;&#101;&#108;&#108;&#111;&#32;&#119;&#111;&#114;&#108;&#100;" }

    it "must XML encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end

    it "must return valid HTML" do
      expect(Nokogiri::HTML.fragment(subject.encode(data)).inner_text).to eq(data)
    end
  end
end
