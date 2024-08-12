require 'spec_helper'
require 'ronin/payloads/encoders/builtin/js/node/base64_encode'

describe Ronin::Payloads::Encoders::JS::Node::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::NodeJSEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::NodeJSEncoder
  end

  describe "#encode" do
    let(:javascript) { %{console.log("PWNED")} }
    let(:encoded) do
      %{eval(Buffer.from("Y29uc29sZS5sb2coIlBXTkVEIik=","base64").toString("ascii"))}
    end

    it "must encode the given String as Base64 and embed it within 'eval(window.btoa(...))'" do
      expect(subject.encode(javascript)).to eq(encoded)
    end
  end
end
