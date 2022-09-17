require 'spec_helper'
require 'ronin/payloads/node_js_payload'

describe Ronin::Payloads::NodeJSPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end
end
