require 'spec_helper'
require 'ronin/payloads/encoders/builtin/js/base64_encode'

describe Ronin::Payloads::Encoders::JS::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::JavaScriptEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::JavaScriptEncoder
  end

  describe "#encode" do
    let(:javascript) { "alert(1)" }
    let(:encoded)    { "eval(window.btoa(\"YWxlcnQoMSk=\"))" }

    it "must encode the given String as Base64 and embed it within 'eval(window.btoa(...))'" do
      expect(subject.encode(javascript)).to eq(encoded)
    end
  end
end
