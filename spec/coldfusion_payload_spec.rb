require 'spec_helper'
require 'ronin/payloads/coldfusion_payload'

describe Ronin::Payloads::ColdFusionPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class).to be < Ronin::Payloads::Payload
  end
end
