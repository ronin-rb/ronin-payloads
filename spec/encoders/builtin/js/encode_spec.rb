require 'spec_helper'
require 'ronin/payloads/encoders/builtin/js/encode'

describe Ronin::Payloads::Encoders::JS::Encode do
  it "must inherit from Ronin::Payloads::Encoders::JavaScriptEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::JavaScriptEncoder
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "\\x68\\x65\\x6C\\x6C\\x6F\\x20\\x77\\x6F\\x72\\x6C\\x64" }

    it "must JavaScript encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
