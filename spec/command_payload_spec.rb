require 'spec_helper'
require 'ronin/payloads/command_payload'

describe Ronin::Payloads::CommandPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::CommandEncoder)
    end
  end
end
