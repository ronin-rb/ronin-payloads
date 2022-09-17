require 'spec_helper'
require 'ronin/payloads/xml_payload'

describe Ronin::Payloads::XMLPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::XMLEncoder)
    end
  end
end
