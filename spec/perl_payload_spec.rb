require 'spec_helper'
require 'ronin/payloads/perl_payload'

describe Ronin::Payloads::PerlPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::PerlEncoder)
    end
  end

  describe ".payload_type" do
    subject { described_class }

    it "must return :perl" do
      expect(subject.payload_type).to eq(:perl)
    end
  end
end
