require 'spec_helper'
require 'ronin/payloads/jsp_payload'

describe Ronin::Payloads::JSPPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class).to be < Ronin::Payloads::Payload
  end
end
