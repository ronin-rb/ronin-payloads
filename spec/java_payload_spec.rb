require 'spec_helper'
require 'ronin/payloads/java_payload'

describe Ronin::Payloads::JavaPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class).to be < Ronin::Payloads::Payload
  end
end
