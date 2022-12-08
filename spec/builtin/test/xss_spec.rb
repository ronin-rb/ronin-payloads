require 'spec_helper'
require 'ronin/payloads/builtin/test/xss'

describe Ronin::Payloads::Test::XSS do
  it "must inherit from Ronin::Payloads::JavaScriptPayload" do
    expect(described_class).to be < Ronin::Payloads::JavaScriptPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/xss'" do
      expect(subject.id).to eq('test/xss')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'alert(1)'" do
      expect(subject.payload).to eq("alert(1)")
    end
  end
end
