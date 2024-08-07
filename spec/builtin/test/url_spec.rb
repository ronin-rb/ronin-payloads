require 'spec_helper'
require 'ronin/payloads/builtin/test/url'

describe Ronin::Payloads::Test::URL do
  it "must inherit from Ronin::Payloads::URLPayload" do
    expect(described_class).to be < Ronin::Payloads::URLPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/url'" do
      expect(subject.id).to eq('test/url')
    end
  end

  describe "#build" do
    context "when the url param is not set" do
      before { subject.build }

      it "must set #payload to 'http://example.com'" do
        expect(subject.payload).to eq('http://example.com')
      end
    end

    context "when the url param is set" do
      let(:url) { 'https://example.com/' }

      before do
        subject.params[:url] = url
        subject.build
      end

      it "must set #payload to the url param" do
        expect(subject.payload).to eq(url)
      end
    end
  end
end
