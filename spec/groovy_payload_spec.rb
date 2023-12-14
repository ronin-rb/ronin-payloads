require 'spec_helper'
require 'ronin/payloads/groovy_payload'

describe Ronin::Payloads::GroovyPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe ".payload_type" do
    it "must return :groovy" do
      expect(described_class.payload_type).to eq(:groovy)
    end
  end
end
