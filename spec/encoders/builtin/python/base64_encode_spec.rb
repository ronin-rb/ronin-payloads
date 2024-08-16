require 'spec_helper'
require 'ronin/payloads/encoders/builtin/python/base64_encode'

describe Ronin::Payloads::Encoders::Python::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::PythonEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PythonEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'python/base64_encode'" do
      expect(subject.id).to eq('python/base64_encode')
    end
  end

  describe "#encode" do
    let(:python)  { "print('PWNED')" }
    let(:encoded) { %{import base64; exec(base64.b64decode("cHJpbnQoJ1BXTkVEJyk="))} }

    it "must encode the given Python code as a Base64 string and embed it into the 'import base64; exec(base64.b64decode(\"...\"))' string" do
      expect(subject.encode(python)).to eq(encoded)
    end
  end
end
