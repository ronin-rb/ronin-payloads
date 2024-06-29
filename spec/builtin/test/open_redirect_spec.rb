require 'spec_helper'
require 'ronin/payloads/builtin/test/open_redirect'

describe Ronin::Payloads::Test::OpenRedirect do
  it "must inherit from Ronin::Payloads::URLPayload" do
    expect(described_class).to be < Ronin::Payloads::URLPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/open_redirect'" do
      expect(subject.id).to eq('test/open_redirect')
    end
  end

  describe "#build" do
    context "when the url param is not set" do
      before { subject.build }

      it "must set #payload to 'https://google.com/'" do
        expect(subject.payload).to eq("https://google.com/")
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
