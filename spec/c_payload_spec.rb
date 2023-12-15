require 'spec_helper'
require 'ronin/payloads/c_payload'

describe Ronin::Payloads::CPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  it "must include Ronin::Payloads::Mixins::CC" do
    expect(described_class).to include(Ronin::Payloads::Mixins::CC)
  end
end
