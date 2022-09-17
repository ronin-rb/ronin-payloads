require 'spec_helper'
require 'ronin/payloads/php_payload'

describe Ronin::Payloads::PHPPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end
end
