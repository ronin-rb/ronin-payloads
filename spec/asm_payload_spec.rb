require 'spec_helper'
require 'ronin/payloads/asm_payload'

describe Ronin::Payloads::ASMPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end
end
