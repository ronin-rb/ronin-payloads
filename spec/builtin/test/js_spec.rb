require 'spec_helper'
require 'ronin/payloads/builtin/test/js'

describe Ronin::Payloads::Test::JS do
  it "must inherit from Ronin::Payloads::JavaScriptPayload" do
    expect(described_class).to be < Ronin::Payloads::JavaScriptPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/js'" do
      expect(subject.id).to eq('test/js')
    end
  end

  describe "#build" do
    context "when the command param is not set" do
      before { subject.build }

      it "must set #payload to `console.log('PWNED');`" do
        expect(subject.payload).to eq(%{console.log('PWNED');})
      end
    end

    context "when the javascript param is set" do
      let(:javascript) { "alert('PWNED');" }

      before do
        subject.params[:javascript] = javascript
        subject.build
      end

      it "must set #payload to the javascript param" do
        expect(subject.payload).to eq(javascript)
      end
    end
  end
end
